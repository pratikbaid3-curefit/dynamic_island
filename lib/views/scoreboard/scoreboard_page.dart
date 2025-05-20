import 'dart:async';
import 'dart:convert';
// import 'package:live_activities/live_activities.dart';
// import 'package:cricket_dynamic_island_app/models/team_response.dart';
// import 'package:cricket_dynamic_island_app/views/scoreboard/widgets/scoreboard_widget.dart';
import 'package:dynamic_island/models/team.dart';
import 'package:dynamic_island/views/scoreboard/widgets/scoreboard_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:live_activities/live_activities.dart';

import '../../models/team_response.dart';
// import 'package:http/http.dart';
// import 'package:workmanager/workmanager.dart';

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     String activityId = inputData!["activityId"];
//     final _liveActivitiesPlugin = LiveActivities();
//     get(Uri.parse("https://prod-public-api.livescore.com/v1/api/app/date/soccer/20230922/5.30?countryCode=IN&locale=en&MD=1")).then((response) async {
//       final teamResponse = TeamResponse.fromJson(jsonDecode(response.body)['Stages'][0]);
//       _liveActivitiesPlugin.updateActivity(activityId, teamResponse.toJson());
//     });
//     return Future.value(true);
//   });
// }

class ScoreboardPage extends StatefulWidget {
  const ScoreboardPage({super.key});

  @override
  State<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  TeamResponse? teamResponse;
  final _liveActivitiesPlugin = LiveActivities();
  late Timer timer;
  String? activityId;

  Future<void> firebaseInitialisation() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final apnsToken = await FirebaseMessaging.instance.getToken();
    if (apnsToken != null) {
      print("APNS: $apnsToken");
      // APNS token is available, make FCM plugin API requests...
    }
  }

  @override
  void initState() {
    firebaseInitialisation();
    _liveActivitiesPlugin.init(appGroupId: "group.cult_dynamic_island");
    teamResponse = TeamResponse(
        team1: Team(
            name: "Pratik",
            id: "XXXX",
            image: "https://lsm-static-prod.livescore.com/high/enet/8306.png",
            abr: "XX",
            score: "2"),
        team2: Team(
            name: "Tejas",
            id: "YYYY",
            image: "https://lsm-static-prod.livescore.com/high/enet/8302.png",
            abr: "YY",
            score: "1"),
        heading: "Hello",
        subHeading: "Hello small");
    initialiseLiveActivity();
    _liveActivitiesPlugin.pushToStartTokenUpdateStream.listen((token) {
      // Send this token to your server
      print('Received push-to-start token: $token');

      // Your server can use this token to create a Live Activity
      // without the user having to open your app first
    });
    setState(() {});
    // timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //   get(Uri.parse("https://prod-public-api.livescore.com/v1/api/app/date/soccer/20230922/5.30?countryCode=IN&locale=en&MD=1")).then((response) async {
    //     teamResponse = TeamResponse.fromJson(jsonDecode(response.body)['Stages'][0]);
    //     if(activityId == null) {
    //       activityId = await _liveActivitiesPlugin.createActivity(teamResponse!.toJson());
    //       print(activityId);
    //     } else {
    //       _liveActivitiesPlugin.updateActivity(activityId!, teamResponse!.toJson());
    //     }
    //     setState(() {});
    //   });
    // });
    super.initState();
  }

  Future<void> initialiseLiveActivity() async {
    if (activityId == null) {
      activityId =
          await _liveActivitiesPlugin.createActivity(teamResponse!.toJson());
      print(activityId);
    } else {
      _liveActivitiesPlugin.updateActivity(activityId!, teamResponse!.toJson());
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent.shade400,
      body: Column(
        children: [
          Center(
            child: teamResponse == null
                ? const CircularProgressIndicator()
                : ScoreboardWidget(teamResponse: teamResponse!),
          ),
          TextButton(
              onPressed: () async {
                final isPushToStartSupported =
                    await _liveActivitiesPlugin.allowsPushStart();
                if (isPushToStartSupported) {}
              },
              child: Text("Press Me!"))
        ],
      ),
    );
  }
}

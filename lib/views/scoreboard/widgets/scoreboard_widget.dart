import 'package:flutter/material.dart';

import '../../../models/team_response.dart';

class ScoreboardWidget extends StatelessWidget {
  final TeamResponse teamResponse;

  const ScoreboardWidget({super.key, required this.teamResponse});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardHeight = MediaQuery.of(context).size.height * 0.3;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
          color: const Color(0xFF4C0033),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
              spreadRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(22)),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/bg.png",
            height: cardHeight,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  teamResponse.heading,
                  style: textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                Text(teamResponse.subHeading,
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Image.network(
                            teamResponse.team1.image,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            teamResponse.team1.name,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${teamResponse.team1.score} : ${teamResponse.team2.score}',
                            style: textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Center(
                              child: Text(
                                "3:23",
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Image.network(
                            teamResponse.team2.image,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            teamResponse.team2.name,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

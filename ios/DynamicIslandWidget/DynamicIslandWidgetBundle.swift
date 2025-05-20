//
//  DynamicIslandWidgetBundle.swift
//  DynamicIslandWidget
//
//  Created by Pratik Baid on 15/05/25.
//

import WidgetKit
import SwiftUI

@main
struct DynamicIslandWidgetBundle: WidgetBundle {
    var body: some Widget {
        DynamicIslandWidget()
        DynamicIslandWidgetControl()
        DynamicIslandWidgetLiveActivity()
    }
}

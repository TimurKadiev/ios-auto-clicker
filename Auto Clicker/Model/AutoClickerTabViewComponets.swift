//
//  AutoClickerTabViewComponets.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

enum AutoClickerTabViewComponets {
    case autoClick, autoScroll, settings, autoCounter
    
    var nameTab: String {
        switch self {
        case .autoClick:
            return "Auto Click"
        case .autoScroll:
            return "Auto Scroll"
        case .settings:
            return "Settings"
        case .autoCounter:
            return "Auto Counter"
        }
    }
    
    var iconTab: String {
        switch self {
        case .autoClick:
            return "autoClick_Icon"
        case .autoScroll:
            return "autoScroll_Icon"
        case .settings:
            return "settings_Icon"
        case .autoCounter:
            return "autoCounter_Icon"
        }
    }
}

//
//  SettingManager.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 22.06.2023.
//

import SwiftUI
import AudioToolbox

class SettingManager {
    @AppStorage("sound_") private var sound = true
     
    static let shared = SettingManager()
    
    func checkOnSound() {
        if sound {
            AudioServicesPlaySystemSound(1104)
        } else {
            
        }
    }
}

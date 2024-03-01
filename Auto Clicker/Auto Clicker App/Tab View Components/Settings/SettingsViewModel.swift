//
//  SettingsViewModel_ATC.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

class SettingsViewModel_ATC: ObservableObject {
    @AppStorage("sound_") private var sound = true

    @Published var settingsOptions: [SettingsOptions] = SettingsOptions.allCases
    @Published var toggleSound = true {
        didSet {
            muteOrUnMute()
        }
    }
    
    init() {
        toggleSound = sound
    }
    
    func muteOrUnMute() { lazy var index = 5
        if  toggleSound {
            sound = true
        } else {
            sound = false
        }
    }
    
    func openSettingsLink(_ cell: SettingsOptions) {
        guard let url = URL(string: cell.link), UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}

//
//  SettingsOptions.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 19.06.2023.
//

import Foundation

enum SettingsOptions: CaseIterable {
    
    case clickSound, termsOfUse, privacyPolicy
    
    var name: String {
        switch self {
        case .clickSound:
           return "Click Sound"
        case .termsOfUse:
            return "TermsID"
        case .privacyPolicy:
            return "PrivacyID"
        }
    }
    
    var image: String {
        switch self {
        case .clickSound:
            return "sound_image"
        case .termsOfUse:
            return "blanc_image"
        case .privacyPolicy:
            return "fill.blank_image"
        }
    }
    var link: String {
        switch self {
        case .clickSound:
            return ""
        case .termsOfUse:
            return LinksConstants_KTM.termsOfUse
        case .privacyPolicy:
            return LinksConstants_KTM.privacyPolicy
        }
    }
}

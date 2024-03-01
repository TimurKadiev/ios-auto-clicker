//
//  ScrollCases.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 19.06.2023.
//

import Foundation

enum ScrollCases_KTM {
    
    case firstSpeed, secondSpeed, thirdSpeed, fourthSpeed
   
    var speedValue: String {
        switch self {
        case .firstSpeed:
            return "0.5x"
        case .secondSpeed:
            return "1.0x"
        case .thirdSpeed:
            return "2.0x"
        case .fourthSpeed:
            return "4.0x"
        }
    }
}

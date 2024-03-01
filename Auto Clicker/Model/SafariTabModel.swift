//
//  SafariTabModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 15.06.2023.
//

import Foundation

enum SafariTabModel: CaseIterable {
    case firstStep, secondStep, thirdStep, fourthStep, fifthStep, sixthStep
    
    var image: String {
        switch self {
        case .firstStep:
            return Device_KTM.iPhone ? "firstStep_image" : "firstStep.iPad_image"
        case .secondStep:
            return Device_KTM.iPhone ? "secondStep_icon_KTM" : "secondStep.iPad_icon"
        case .thirdStep:
            return Device_KTM.iPhone ? "thirdStep_image" : "thirdStep.iPad_image"
        case .fourthStep:
            return Device_KTM.iPhone ? "fourthStep_image" : "fourthStep.iPad_image"
        case .fifthStep:
            return Device_KTM.iPhone ? "sixthStep_image" : "fifthStep.iPad_image"
        case .sixthStep:
            return Device_KTM.iPhone ? "fifthStep_image" : "sixthStep.iPad_image"
        }
    }
    
    var instructionText: String {
        switch self {
        case .firstStep:
            return "description1"
        case .secondStep:
            return "description2"
        case .thirdStep:
            return "description3"
        case .fourthStep:
            return "description4"
        case .fifthStep:
            return "description5"
        case .sixthStep:
            return "description6"
        }
    }
}

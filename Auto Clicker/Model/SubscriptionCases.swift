//
//  SubscriptionCases.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 07.02.2024.
//

import Foundation

enum SubscriptionCases_KTM {
    
    case stCollection, ndCollection, proposalScreen
    
    var ref_KTM: String {
        switch self {
        case .stCollection:
            return ""
        case .ndCollection:
            return ""
        case .proposalScreen:
            return ""
        }
    }
}

//
//  MultiClickModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 22.06.2023.
//

import SwiftUI
import Combine

struct MultiClickModel: Identifiable {
    let id = UUID()
    let tapNumber: Int
    var min = "0" {
        didSet {
            let filteredString = min.filter { $0.isNumber }
            if filteredString != min {
                min = filteredString
            }
        }
    }
    var sec = "1" {
        didSet {
            let filteredString = sec.filter { $0.isNumber }
            if filteredString != sec {
                sec = filteredString
            }
            if let seconds = Int(sec) {
                if seconds > 59 {
                    sec = "59"
                }
            }
        }
    }
    var clickingNow = false
    var offsetWidth = 0.0
    var offsetHeight = 0.0
}

//
//  UIDevice.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 23.06.2023.
//

import Foundation
import UIKit

enum Device_KTM {
    static var iPhone: Bool {
        guard UIDevice().userInterfaceIdiom == .phone else {
                return false
        }
        return true
    }
}

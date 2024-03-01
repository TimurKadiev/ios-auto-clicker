//
//  AutoClickCellsModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoClickCellsModel: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var isUnlocked: Bool = false
    var image: String 
}

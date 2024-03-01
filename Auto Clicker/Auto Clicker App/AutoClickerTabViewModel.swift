//
//  AutoClickerTabViewModel.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

class AutoClickerTabViewModel: ObservableObject {
    @Published var autoClickerTabView: AutoClickerTabViewComponets = .autoClick {
        didSet {
            UIApplication.shared.endEditing_KTM()
        }
    }
    var previousTabView: AutoClickerTabViewComponets?
}



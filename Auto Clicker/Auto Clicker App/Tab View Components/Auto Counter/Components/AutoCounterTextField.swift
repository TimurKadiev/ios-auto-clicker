//
//  AutoCounterTextField.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 15.01.2024.
//

import SwiftUI
import Combine

struct AutoCounterTextField: View {
    @Binding var clickDisplayViewTextFieldMin: String
    @Binding var focused: Bool
    @State var text: String

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if focused {
                    Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24)
                } else {
                    Color.black.opacity(0.04)
                        .cornerRadius(Device_KTM.iPhone ? 12 : 24)
                }

                TextField("0", text: $clickDisplayViewTextFieldMin, onEditingChanged: getFocus)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                    .foregroundColor(.black)
                    .keyboardType(.numberPad)
                    .onReceive(Just(clickDisplayViewTextFieldMin)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.clickDisplayViewTextFieldMin = filtered
                                    }
                                }
            }
            .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.16 : 0.117),  height: ScreenSize_KTM.KTM_height *  (Device_KTM.iPhone ? 0.054: 0.064))
            
            Text(NSLocalizedString(text, comment: ""))
                .foregroundColor(.black)
                .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 13 : 26))
        }
    }
    func  getFocus ( focused : Bool ) { lazy var count = 45
        self.focused = focused
        var value1 = 1
    }
}

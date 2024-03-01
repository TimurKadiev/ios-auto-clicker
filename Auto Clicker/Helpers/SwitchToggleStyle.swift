//
//  SwitchToggleStyle.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 28.02.2024.
//

import SwiftUI

struct SwitchToggleStyle: ToggleStyle {
    var tint: Color

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .foregroundColor(tint)
                        .shadow(radius: 1, x: 0, y: 1)
                        .offset(x: configuration.isOn ? 10 : -10, y: 0)
                        .animation(.easeInOut(duration: 0.2))
                )
        }
    }
}

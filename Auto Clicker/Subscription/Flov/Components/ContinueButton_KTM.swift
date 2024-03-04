//
//  ContinueButton.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 06.02.2024.
//

import SwiftUI

struct ContinueButton_KTM: View {
    @State private var scale: CGFloat = 0.9
    var action: EmptyBlock
    var body: some View {
        Button {
            action()
            UIImpactFeedbackGenerator.trigger(style: .medium)
        } label: {
            ZStack(alignment: .trailing) {
                Image("safari_exit_image")
                    .zIndex(1)
                    .padding(.trailing, ScreenSize_KTM.KTM_width * 0.05)
                    .scaleEffect(Device_KTM.iPhone ? 2.5 : 3)
                HStack(spacing: 34) {
                    Text(NSLocalizedString("CONTINUE", comment: ""))
                        .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 32 : 32).weight(.black))
                        .foregroundColor(Color(red: 0.62, green: 0.89, blue: 1))
                }
                .padding(.vertical, Device_KTM.iPhone ? 19 : 20)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.49, green: 0.49, blue: 0.49)).cornerRadius(6)
            }
        }
        .scaleEffect(scale)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                scale = 0.7
            }
        }
    }
}

#Preview {
    ContinueButton_KTM(action: {})
}

extension UIImpactFeedbackGenerator {
    static func trigger(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}

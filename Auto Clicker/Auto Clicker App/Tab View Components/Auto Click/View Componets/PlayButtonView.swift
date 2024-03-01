//
//  TVRemoteButton.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 16.01.2024.
//

import SwiftUI

struct PlayButtonView: View {
    var image: String
    var action: EmptyBlock
    var body: some View {
        Button {
            action()
        } label: {
            Image(image)
                .foregroundColor(.white)
                .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                .padding(Device_KTM.iPhone ? 9 : 34)
                .background(Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24))
        }
    }
}

#Preview {
    PlayButtonView(image: "onoff_image", action: ({}))
}

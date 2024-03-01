//
//  LinkCell.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 16.06.2023.
//

import SwiftUI

struct LinkCell: View {
    @Binding var blackout: Bool
    @Binding var selectId: UUID
    let image: String
    let name: String
    let id: UUID
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: Device_KTM.iPhone ? 14 : 26) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.28 : 0.18))
                    .foregroundColor(Color.black)
                    .zIndex(0)
                
                Text(NSLocalizedString(name, comment: ""))
                    .lineLimit(1)
                    .font(.system(size: Device_KTM.iPhone ? 20 : 37, weight: .medium))
                    .foregroundColor(.black)
            }
            .disabled(blackout)
            .padding(.vertical, Device_KTM.iPhone ? 24 : ScreenSize_KTM.KTM_height * 0.03)
            .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.4 : 0.286), height: ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.23 :  0.254))
            .background(Color.white.opacity(blackout ? 0.1 : 1).cornerRadius(Device_KTM.iPhone ? 14 : 26))
            .shadow(color: .shadowColor, radius: 19)
        }
    }
}

#Preview {
    LinkCell(blackout: .constant(true), selectId: .constant(.init()), image: "", name: "", id: .init())
}

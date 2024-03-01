//
//  CardView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 24.01.2024.
//

import SwiftUI

struct CardView: View {
    var isSelected: Bool
    var body: some View {
        VStack {
           
            ZStack {
                Rectangle()
                    .foregroundColor((Color(red: 0.9, green: 0.9, blue: 0.9)))
                    .cornerRadius(6)
                Text(isSelected ? "Activ Card" : "Inactiv card")
                    .textCase(.uppercase)
                    .font(Font.custom("Poller One", size: isSelected ? Device_KTM.iPhone ? 19 : 30 : Device_KTM.iPhone ? 14 : 20))
                    .foregroundColor(isSelected ? .textCostomGray : .textCostomGray.opacity(0.5))
                    .shadow(color: .black.opacity(0.25), radius: 2, y: 2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: isSelected ? ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.25 : 0.15) : ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.21 : 0.12),
                   height: isSelected ? ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.11 : 0.1 ) : ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.096 : 0.082))
            
            Text("CARD NAME")
                .font(Font.custom("Poller One", size: isSelected ? Device_KTM.iPhone ? 12 : 18 : Device_KTM.iPhone ? 10 : 14))
                .foregroundColor(isSelected ? .white : .white).opacity(0.7)
                .shadow(color: .black.opacity(0.25), radius: 1.2, y: 1.2)
        }
        .padding(Device_KTM.iPhone ? 5 : 5)
        .background(isSelected ? Color.gray_BCBCBC : Color.gray_7E7E7E)
        .cornerRadius(6)
    }
}

#Preview {
    CardView(isSelected: false)
}

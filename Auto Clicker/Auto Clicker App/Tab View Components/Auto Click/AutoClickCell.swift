//
//  AutoClickCell.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoClickCell: View {
    let name: String
    let description: String
    let image: String
    
    var body: some View {
        VStack(spacing: 13) {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.064 : 0.04))
                    .foregroundColor(.black)
                
                Text(NSLocalizedString(name, comment: ""))
                    .font(.system(size: Device_KTM.iPhone ? 20 : 32, weight: .medium))
                    .padding(.bottom, 1)
                    .foregroundColor(.black)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.08 : 0.052))
                        .foregroundColor(.black)
                    Image("arrow_left_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: ScreenSize_KTM.KTM_width *  (Device_KTM.iPhone ? 0.053 :  0.035))
                        .foregroundColor(.white)
                }
            }
            
            HStack {
                Text(NSLocalizedString(description, comment: ""))
                    .font(.system(size: Device_KTM.iPhone ? 13 : 22, weight: .light))
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(.horizontal, Device_KTM.iPhone ? 14 : 20)
        .multilineTextAlignment(.leading)
        .padding(.bottom, 14)
        .padding(.top, 17)
        .background(Color.white.cornerRadius(12))
        .shadow(color: Color.shadowColor, radius: 12)
    }
}

struct AutoClickCell_Previews: PreviewProvider {
    static var previews: some View {
        AutoClickCell(name: "Single Click Mode", description: "Set up single click on your custom browser ", image: "monitor-play_image")
    }
}

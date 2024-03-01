//
//  TabItemView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct TabItemView: View {
    @ObservedObject var viewModel: AutoClickerTabViewModel
    let item: AutoClickerTabViewComponets
    private var isSelected: Bool {
        viewModel.autoClickerTabView == item
    }
    
    var body: some View {
        Button {
            viewModel.autoClickerTabView = item
        } label: {
            VStack(spacing: Device_KTM.iPhone ? 4 : 8) {
                if Device_KTM.iPhone {
                    Image(item.iconTab)
                        .resizable()
                        .scaledToFit()
                        .frame(width: ScreenSize_KTM.KTM_width * 0.07)
                        .colorMultiply(isSelected ? .white : .black)
                } else {
                    Image(item.iconTab)
                        .resizable()
                        .scaledToFit()
                        .frame(width: ScreenSize_KTM.KTM_width * 0.05)
                        .colorMultiply(isSelected ? .white : .black)
                }
                Text(NSLocalizedString(item.nameTab, comment: ""))
                    .lineLimit(1)
                    .font(.system(size: Device_KTM.iPhone ? 12 : 24, weight: .light))
                    .foregroundColor(isSelected ? .white : .black)
            }
        }
        .frame(width: Device_KTM.iPhone ? ScreenSize_KTM.KTM_width * 0.21 :ScreenSize_KTM.KTM_width * 0.185 )
        .padding(.vertical, Device_KTM.iPhone ? 8 : 14)
        .background(isSelected ? Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24) : Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24))
        .shadow(color: isSelected ? .clear : .shadowColor, radius: Device_KTM.iPhone ? 12 : 24)
    }
}

#Preview(body: {
    TabItemView(viewModel: AutoClickerTabViewModel(), item: .autoCounter)
})



//
//  TabBarView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct TabBarViewKTM: View {
    @ObservedObject var viewModel: AutoClickerTabViewModel
    @State var isEnb = false
    @State var visible = true
    
    var body: some View {
        HStack {
            TabItemView(viewModel: viewModel, item: .autoClick)
                .isVisible_KTM(visible)
            Spacer()
            TabItemView(viewModel: viewModel, item: .autoScroll)
                .isVisible_KTM(visible)
            Spacer()
            TabItemView(viewModel: viewModel, item: .autoCounter)
                .isVisible_KTM(visible)
            Spacer()
            tabBarButton
        }
        .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
        .frame(width: ScreenSize_KTM.KTM_width, height: Device_KTM.iPhone ? 50 : ScreenSize_KTM.KTM_height * 0.075)
        .padding(.bottom, Device_KTM.iPhone ? 17 : 30)
        .ignoresSafeArea()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarViewKTM(viewModel: AutoClickerTabViewModel())
    }
}

extension TabBarViewKTM {
    private var tabBarButton: some View {
        Button {
            withAnimation {
                visible.toggle()
            }
        } label: {
            Image(Device_KTM.iPhone ? "arrow_left_image" : "ipad_tab_image")
                .resizable()
                .scaledToFit()
                .frame(width: Device_KTM.iPhone ? 40 : ScreenSize_KTM.KTM_width * 0.08)
                .foregroundColor(visible ? .black : .white )
                .rotationEffect(.degrees(visible ? 0 : 180))
        }
        .padding(Device_KTM.iPhone ? 9 : 18)
        .background(visible ? Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24) : Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24))
        .shadow(color: .shadowColor, radius: 12)
    }
}

struct Show: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        }
    }
}

//
//  ContentView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoClickerTabView: View {
    @EnvironmentObject var appViewModel: AutoClickViewModel
    @StateObject var viewModel = AutoClickerTabViewModel()
    @State var showingSubscriptionView = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.autoClickerTabView) {
                AutoClickViewKTM()
                    .tag(AutoClickerTabViewComponets.autoClick)
                AutoScrollViewKTM()
                    .onChange(of: viewModel.autoClickerTabView) { newValue in
                        if newValue == .autoScroll && !appViewModel.autoScrollProductIsEnabled {
                            viewModel.previousTabView = .autoClick
                            showingSubscriptionView = true
                        }
                    }
                    .tag(AutoClickerTabViewComponets.autoScroll)
                AutoCounterViewKTM()
                    .tag(AutoClickerTabViewComponets.autoCounter)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            TabBarViewKTM(viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $showingSubscriptionView) {
            SubscriptionScreenView(mainScren: .autoScrollProduct, showAlert: .constant(false), closeAction: {
                if let previousTab = viewModel.previousTabView {
                    viewModel.autoClickerTabView = previousTab
                }
            })
                .environmentObject(IAPManager_MFTW.shared)
        }
        .background(Color.backgraungColor)
        .ignoresSafeArea()
    }
}

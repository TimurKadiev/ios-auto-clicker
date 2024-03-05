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
    @EnvironmentObject var vm: AutoCounterViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.autoClickerTabView) {
                AutoClickViewKTM()
                    .tag(AutoClickerTabViewComponets.autoClick)
                AutoScrollViewKTM()
                    .tag(AutoClickerTabViewComponets.autoScroll)
                AutoCounterViewKTM()
                    .tag(AutoClickerTabViewComponets.autoCounter)
                    
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            TabBarViewKTM(viewModel: viewModel)
        }
        
        .background(Color.backgraungColor)
        .ignoresSafeArea()
    }
}

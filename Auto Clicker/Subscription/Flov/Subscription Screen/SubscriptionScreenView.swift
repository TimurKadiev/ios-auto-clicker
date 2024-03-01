//
//  SubscriptionScreenView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 23.01.2024.
//

import SwiftUI
import AVKit

struct SubscriptionScreenView: View {
    @EnvironmentObject var iapVM: IAPManager_MFTW
    @State var mainScren: PremiumMainControllerStyle_KTM
    @State var screenSequence: SubscriptionCases_KTM = .stCollection
    @State var select: [Int] = []
    @State var isPlay = true
    var closeAction: EmptyBlock
    
    private var player: AVPlayer {
        guard let path = Bundle.main.url(forResource: "Short3 iPhone", withExtension: "mp4") else {
            fatalError("Видео не найдено в Asset Catalog")
        }
        return AVPlayer(url: path)
    }
    
    var body: some View {
        switch mainScren {
        case .mainProduct:
            mainScreen
        case .multiClickProduct:
            TransactionView(isShowExitButton: true, action: {
                iapVM.purchase_MFTW(product: .multiClic)
            }, closeAction: closeAction)
        case .autorefreshProduct:
            TransactionView(isShowExitButton: true,action: {
                iapVM.purchase_MFTW(product: .autoRefresh)
            }, closeAction: closeAction)
        case .splitClickProduct:
            TransactionView(isShowExitButton: true,action: {
                iapVM.purchase_MFTW(product: .main)
            }, closeAction: closeAction)
        case .safariClickProduct:
            TransactionView(isShowExitButton: true,action: {
                iapVM.purchase_MFTW(product: .safaariClick)
            }, closeAction: closeAction)
        case .autoScrollProduct:
            TransactionView(isShowExitButton: true,action: {
                iapVM.purchase_MFTW(product: .autoScroll)
            }, closeAction: closeAction)
        }
    }
}

#Preview {
    SubscriptionScreenView(mainScren: .mainProduct, closeAction: ({}))
        .environmentObject(IAPManager_MFTW.shared)
}

extension SubscriptionScreenView {
    @ViewBuilder private var mainScreen: some View {
        switch screenSequence {
        case .stCollection:
            SelectionSubscriptionView(player: player, isPlaying: $isPlay) {
                ThirdPartyServicesManager_KTM.shared.makeATT()
                screenSequence = .ndCollection
                isPlay = false
            }
        case .ndCollection:
            SelectionSubscriptionView(player: player, isPlaying: $isPlay) {
                ThirdPartyServicesManager_KTM.shared.makeATT()
                screenSequence = .proposalScreen
            }
            .onAppear {
                isPlay = true
            }
        case .proposalScreen:
            TransactionView(isShowExitButton: false,action: {
                iapVM.purchase_MFTW(product: .main)
            }, closeAction: closeAction)
        }
    }
}

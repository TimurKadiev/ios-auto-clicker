//
//  Auto_ClickerApp.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

@main
 struct KTM_AutoClickerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var productToBuy = ProductToBuyPoeTTT.main
    @State private var didCheckForSub = false
    @State private var showAlert = false

    var body: some Scene {
        WindowGroup {
//            if productToBuy.isEnabled && didCheckForSub {
                AutoClickerTabView()
                    .onAppear {
                        showAlert = !InternetManager_KTM.shared.checkInternetConnectivity_KTM()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(NSLocalizedString( "Text30ID", comment: "")), message: Text(NSLocalizedString("Text31ID", comment: "")), dismissButton: .default(Text("OK")))
                    }
                    .environmentObject(AutoClickViewModel())
                    .preferredColorScheme(.light)
//            } else {
//                if !didCheckForSub {
//                    VStack {
//                        Color(.clear)
//                    }
//                    .onAppear {
//                        IAPManager_MFTW.shared.validateSubscriptions_MFTW(completion: { isSuccess in
//                            didCheckForSub = true
//                        })
//                    }
//                    .ignoresSafeArea()
//                }
//                else {
//                    SubscriptionScreenView(mainScren: .mainProduct, showAlert: $showAlert, closeAction: ({}))
//                        .environmentObject(IAPManager_MFTW.shared)
//                        .onAppear {
//                            showAlert = !InternetManager_KTM.shared.checkInternetConnectivity_KTM()
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                                ThirdPartyServicesManager_KTM.shared.makeATT()
//                            }
//                        }
//                        .alert(isPresented: $showAlert) {
//                            Alert(title: Text(NSLocalizedString( "Text30ID", comment: "")), message: Text(NSLocalizedString("Text31ID", comment: "")), dismissButton: .default(Text("OK")))
//                        }
//                        .ignoresSafeArea()
//                }
//            }
        }
    }
}

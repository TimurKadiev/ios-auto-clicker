//
//  Auto_ClickerApp.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

@main
struct KTM_AutoClickerApp: App {
    @State private var showAlert = false

    var body: some Scene {
        WindowGroup {
            AutoClickerTabView()
                .environmentObject(AutoClickViewModel())
                .environmentObject(AutoCounterViewModel())
                .preferredColorScheme(.light)
                .onAppear {
                    showAlert = !InternetManager_KTM.shared.checkInternetConnectivity_KTM()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(NSLocalizedString( "Text30ID", comment: "")), message: Text(NSLocalizedString("Text31ID", comment: "")), dismissButton: .default(Text("OK")))
                }
        }
    }
}

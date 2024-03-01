//
//  AutoClickView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoClickViewKTM: View {
    @EnvironmentObject var appViewModel: AutoClickViewModel
    
    @State var isEnable = false
    var body: some View {
        VStack(spacing: Device_KTM.iPhone ? 32 : 48) {
            heder
                .padding(.top, Device_KTM.iPhone ? 20 : 41)
            content
        }
        .fullScreenCover(isPresented: $appViewModel.clickModeView) {
            ClickView(title: appViewModel.title)
        }
        .fullScreenCover(isPresented: $appViewModel.safariClickModeView) {
            SafariView()
        }
        .fullScreenCover(isPresented: $appViewModel.showSettings, content: {
            SettingScreen_KTM()
                .onDisappear {
                    appViewModel.showSettings = false
                }
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
}

struct AutoClickView_Previews: PreviewProvider {
    static var previews: some View {
        AutoClickViewKTM()
            .environmentObject(AutoClickViewModel())
    }
}

extension AutoClickViewKTM {
    private var heder: some View {
        HStack {
            Spacer()
            Text(NSLocalizedString( "Auto Click", comment: ""))
                .font(.system(size: Device_KTM.iPhone ? 26 : 52, weight: .bold))
                .padding(.leading, Device_KTM.iPhone ? 51 : 102)
                .foregroundColor(.black)
            Spacer()
            Button {
                appViewModel.showSettings = true
            } label: {
                Image("settings_Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Device_KTM.iPhone ? 32 : 64)
                    .padding(.trailing, Device_KTM.iPhone ? 19 : 38)
                    .foregroundColor(.black)
            }
        }
    }
    private var content: some View {
        ScrollView(showsIndicators: false) {
            if Device_KTM.iPhone {
                LazyVStack(spacing: 14) {
                    ForEach(appViewModel.autoClickCells) { cells in
                        Button {
                            appViewModel.openCellsFullScreen(cells)
                        } label: {
                            AutoClickCell(name: cells.name, description: cells.description, image: cells.image)
                        }
                    }
                }
                .padding(.horizontal, Device_KTM.iPhone ? 28 : 48)
                .padding(.vertical)
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: ScreenSize_KTM.KTM_width * 0.028)], spacing: ScreenSize_KTM.KTM_width * 0.02) {
                    ForEach(appViewModel.autoClickCells) { cells in
                        Button {
                            appViewModel.openCellsFullScreen(cells)
                        } label: {
                            AutoClickCell(name: cells.name, description: cells.description, image: cells.image)
                        }
                    }
                }
                .padding(.horizontal, Device_KTM.iPhone ? 28 : ScreenSize_KTM.KTM_width * 0.046)
                .padding(.vertical)
            }
            Spacer(minLength: 80)
        }
    }
}

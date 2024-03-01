//
//  SettingsView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct SettingScreen_KTM: View {
    @StateObject var viewModel = SettingsViewModel_ATC()
    @Environment(\.presentationMode) var presentationMode
    @State private var isToggled = false

    var body: some View {
        settingsView
    }

    @ViewBuilder
    private func settingsButton(cell: SettingsOptions) -> some View {
        Button {
            viewModel.openSettingsLink(cell)
        } label: {
            VStack(alignment: .leading, spacing: Device_KTM.iPhone ? ScreenSize_KTM.KTM_height * 0.017 : ScreenSize_KTM.KTM_height * 0.027) {
                HStack {
                    Image(cell.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.048 : 0.031))
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
                
                Text(NSLocalizedString(cell.name, comment: "") )
                    .font(.system(size: Device_KTM.iPhone ? 20 : ScreenSize_KTM.KTM_width < 800 ? 28 : 30, weight: .medium))
                    .foregroundColor(.black)
                
            }
            .padding(.horizontal,  Device_KTM.iPhone ? 15 : ScreenSize_KTM.KTM_width * 0.027)
            .padding(.top, Device_KTM.iPhone ? 13 : ScreenSize_KTM.KTM_height * 0.026)
            .padding(.bottom,  Device_KTM.iPhone ? 8 : ScreenSize_KTM.KTM_height * 0.022)
            .background(Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24))
        }
    }

    @ViewBuilder
    private func soundToggle(cell: SettingsOptions) -> some View {
        VStack(alignment: .leading, spacing:  Device_KTM.iPhone ? ScreenSize_KTM.KTM_height * 0.017 : ScreenSize_KTM.KTM_height * 0.027) {
            HStack {
                Image(cell.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.053 : 0.035))
                    .foregroundColor(.black)
                
                Spacer()
                Toggle(isOn: $viewModel.toggleSound) {
                    Text("")
                }
                .padding(.trailing, 5)
                .toggleStyle(SwitchToggleStyle(tint: viewModel.toggleSound ? .white : .black))
                .frame(width: ScreenSize_KTM.KTM_width * 0.1, height: ScreenSize_KTM.KTM_height * 0.045)
                
                .scaleEffect(Device_KTM.iPhone ? 1.0 : 1.5)
                .foregroundColor(viewModel.toggleSound ? .black : Color.backgraungColor)
                .animation(.easeInOut(duration: 0.2))
                
            }
            Text(NSLocalizedString(cell.name, comment: "") )
                .font(.system(size: Device_KTM.iPhone ? 20 : ScreenSize_KTM.KTM_width < 800 ? 28 : 30, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.horizontal,  Device_KTM.iPhone ? 15 : ScreenSize_KTM.KTM_width * 0.027)
        .padding(.top, Device_KTM.iPhone ? 13 : ScreenSize_KTM.KTM_height * 0.026)
        .padding(.bottom,  Device_KTM.iPhone ? 8 : ScreenSize_KTM.KTM_height * 0.022)
        .background(Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24))
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingScreen_KTM()
        }
    }
}

extension SettingScreen_KTM {
    private var settingsView: some View {
        ScrollView {
            VStack {
                heder
                
                content
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .frame(height: ScreenSize_KTM.KTM_height)
        .onAppear {
            print(ScreenSize_KTM.KTM_width)
            print(ScreenSize_KTM.KTM_height)
        }
        .background(Color.backgraungColor)
        .ignoresSafeArea()
    }
    private var heder: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image("left_image_KTM")
                    .scaleEffect(Device_KTM.iPhone ? 1 : 1.5)
            }
            
            Spacer()
            Text(NSLocalizedString("Settings", comment: ""))
                .font(.system(size: Device_KTM.iPhone ? 26 : 52, weight: .bold))
                .padding(.trailing, 34)
            Spacer()
        }
        .padding(.top, Device_KTM.iPhone ? ScreenSize_KTM.KTM_height * 0.06: 41)
        .foregroundColor(.black)
    }
    private var content: some View {
        LazyVGrid(columns: Device_KTM.iPhone ? Array(repeating: GridItem(spacing: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.037 : 0.023)), count: 2) : Array(repeating: GridItem(spacing: 24), count: 3), spacing: ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.017 : 24)) {
            ForEach(viewModel.settingsOptions, id: \.name) { cell in
                if cell != .clickSound {
                    settingsButton(cell: cell)
                } else {
                    soundToggle(cell: cell)
                }
            }
        }
    }
}



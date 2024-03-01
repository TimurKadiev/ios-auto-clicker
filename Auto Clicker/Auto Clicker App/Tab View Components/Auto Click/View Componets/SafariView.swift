//
//  SafariView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 15.06.2023.
//

import SwiftUI

struct SafariView: View {
    @EnvironmentObject var viewModel: AutoClickViewModel
    var body: some View {
        VStack(spacing: 0) {
            heder
            
            VStack {
                content
                    .padding(.horizontal, Device_KTM.iPhone ? 24 : ScreenSize_KTM.KTM_width * 0.1)
                
                button
                    .padding(.horizontal, Device_KTM.iPhone ? 24 : ScreenSize_KTM.KTM_width * 0.18)
                
                Spacer()
            }
            .padding(.top, ScreenSize_KTM.KTM_height * 0.04)
        }
        .background(Color.safariBackgraund)
        .ignoresSafeArea()
    }
}

struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView()
            .environmentObject(AutoClickViewModel())
    }
}

extension SafariView {
    private var heder: some View {
        VStack(spacing: 14) {
            HStack(spacing: Device_KTM.iPhone ? 7 : 24 ) {
                ForEach(viewModel.safariTabModel, id: \.instructionText) { index in
                    Rectangle()
                        .fill(viewModel.safariTab == index ? Color.white : Color.white.opacity(0.4))
                        .frame(width: ScreenSize_KTM.KTM_width * 0.13, height: 4)
                }
            }
            
            HStack {
                Spacer()
                Button {
                    viewModel.closeSafariClickModeView()
                    viewModel.safariTab = .firstStep
                } label: {
                    Text(NSLocalizedString("exit", comment: ""))
                        .foregroundColor(.white)
                        .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                    if Device_KTM.iPhone {
                        Image("safari_exit_image")
                    } else {
                        Image("safari_exit_image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }
            }
        }
        .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
        .padding(.top, ScreenSize_KTM.KTM_height * 0.07)
    }
    private var button: some View {
        Button {
            if viewModel.safariTab == .sixthStep {
                viewModel.closeSafariClickModeView()
                viewModel.safariTab = .firstStep
            } else {
                viewModel.safariTab = viewModel.safariTab.next_KTM()
            }
        } label: {
            HStack {
                Text(NSLocalizedString("CONTINUE", comment: ""))
                    .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Device_KTM.iPhone ? 17 : 34)
            .background(Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24))
        }
        .padding(.bottom, 30)
    }
    private var content: some View {
        TabView(selection: $viewModel.safariTab) {
            ForEach(viewModel.safariTabModel, id:\.self) { step in
                VStack(spacing: Device_KTM.iPhone ? 16 : 44) {
                    Text(NSLocalizedString(step.instructionText, comment: "") )
                        .foregroundColor(.white)
                        .font(.system(size: Device_KTM.iPhone ? 18 : 32, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, -10)
                    
                    if ScreenSize_KTM.KTM_height <= 700 {
                        if step == SafariTabModel.firstStep ||
                            step == SafariTabModel.secondStep ||
                            step == SafariTabModel.fifthStep {
                            Image(step.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ScreenSize_KTM.KTM_height * 0.5)
                        } else {
                            Image(step.image)
                        }
                    } else {
                        if Device_KTM.iPhone {
                            Image(step.image)
                        } else {
                            Image(step.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ScreenSize_KTM.KTM_width * 0.5)
                        }
                    }
                    Spacer()
                }
                .tag(step)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

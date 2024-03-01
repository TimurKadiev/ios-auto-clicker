//
//  AutoCounterView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoCounterViewKTM: View {
    @StateObject var viewModel = AutoCounterViewModel()
    var body: some View {
        ZStack {
            colorScheme
            
            VStack {
                heder
                    .padding(.top, Device_KTM.iPhone ? 20 : 41)
                
                Spacer()
                
                ClickDisplayView(
                    textFieldMin: $viewModel.clickDisplayViewTextFieldMin,
                    textFieldSec: $viewModel.clickDisplayViewTextFieldSec,
                    textFieldCount: $viewModel.clickDisplayViewTextFieldCount,
                    focusedMin: $viewModel.focusedMin,
                    focusedSec: $viewModel.focusedSec,
                    focusedCount: $viewModel.focusedCount,
                    startClic: $viewModel.startClick,
                    clickCounts: $viewModel.clickCounts,
                    isRefresh: false,
                    action: {
                        viewModel.startClick.toggle()
                        viewModel.startStopClick()
                    }, closeAction: { }
                )
                .padding(.horizontal, Device_KTM.iPhone ? 14 : 28)
                .frame(width: Device_KTM.iPhone ? ScreenSize_KTM.KTM_width - 48 : ScreenSize_KTM.KTM_width * 0.8)
                .background(viewModel.focusedMin || viewModel.focusedSec || viewModel.focusedCount ? Color.white.opacity(0.2).cornerRadius(Device_KTM.iPhone ? 20 : 40) : Color.white.cornerRadius(Device_KTM.iPhone ? 20 : 40))
                .shadow(color: .shadowColor, radius: 12)
                .padding(.top, -100)
            
                Spacer()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text(NSLocalizedString(viewModel.textForAlert, comment: "")),
                      dismissButton: .default(Text("OK")))
            }
        }
        .fullScreenCover(isPresented: $viewModel.showSettings, content: {
            SettingScreen_KTM()
                .onDisappear {
                    viewModel.showSettings = false
                }
        })
        .onTapGesture {
            withAnimation {
                UIApplication.shared.endEditing_KTM()
            }
        }
        .onDisappear {
            viewModel.startClick = false
            viewModel.startStopClick()
        }
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
}

struct AutoCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AutoCounterViewKTM()
    }
}


extension AutoCounterViewKTM {
   @ViewBuilder private var colorScheme: some View {
        if viewModel.focusedMin || viewModel.focusedSec || viewModel.focusedCount  {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
        } else {
            Color.backgraungColor
                .ignoresSafeArea()
        }
    }
    private var heder: some View {
        HStack {
            Spacer()
            
            Text(NSLocalizedString("Auto Counter", comment: ""))
                .font(.system(size: Device_KTM.iPhone ? 26 : 52 , weight: .bold))
                .padding(.leading, Device_KTM.iPhone ? 51 : 102)
                .foregroundColor(.black)
            Spacer()
            Button {
                viewModel.showSettings = true
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
}



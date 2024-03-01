//
//  AutoScrollView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 14.06.2023.
//

import SwiftUI

struct AutoScrollViewKTM: View, KeyboardReadable_KTM {
    @StateObject var viewModel = AutoScrollViewModel()
    var body: some View {
        ZStack {
            colorScheme
            
            ScrollView {
                VStack(spacing: Device_KTM.iPhone ? 28 : 48) {
                    heder
                        .padding(.top, Device_KTM.iPhone ? 20 : 41)
                    
                    search
                    
                    HStack {
                        Text(NSLocalizedString( "title1", comment: ""))
                            .font(.system(size: Device_KTM.iPhone ? 20 : 40, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.leading, Device_KTM.iPhone ? 24 : 88)
                        Spacer()
                    }
                    
                    LazyVGrid(columns: Device_KTM.iPhone ? Array(repeating: GridItem(spacing: 14), count: 2) : Array(repeating: GridItem(spacing: 24), count: 3), spacing: Device_KTM.iPhone ? 14 : 24) {
                            ForEach(viewModel.fastLinkCollection) { cell in
                                Button {
                                    viewModel.tapOnFastLink(cell)
                                } label: {
                                    LinkCell(blackout: $viewModel.showMenuPopUp, selectId: $viewModel.idSelect, image: cell.image, name: cell.name, id: cell.id)
                                }
                            }
                        }
                    .disabled(viewModel.searchIsActive)
                    .padding(.horizontal, Device_KTM.iPhone ? 20 : 48)
                }
                .frame(width: ScreenSize_KTM.KTM_width)
                .alert(isPresented: $viewModel.showNoInternetAlert) {
                    Alert(title: Text("Error"),
                          message:  Text(NSLocalizedString( "InternetError", comment: "")),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
        .preferredColorScheme(.light)
        .fullScreenCover(isPresented: $viewModel.scrollModeView) {
            webView
                .onDisappear {
                    viewModel.tapToCloseScrollSettings()
                }
        }
        .fullScreenCover(isPresented: $viewModel.showSetting, content: {
            SettingScreen_KTM()
                .onDisappear {
                    viewModel.showSetting = false
                }
        })
        .transaction({ transaction in
            transaction.disablesAnimations = true
        })
    }
    func  getFocus ( focused : Bool ) { lazy var ref = true
        viewModel.searchIsActive = focused
        viewModel.showMenuPopUp = focused
        let count = 199
    }
}

struct AutoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AutoScrollViewKTM()
    }
}

extension AutoScrollViewKTM {
    @ViewBuilder private var colorScheme: some View {
        if viewModel.showMenuPopUp {
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
            
            Text(NSLocalizedString( "Auto Scroll", comment: ""))
                .font(.system(size: Device_KTM.iPhone ? 26 : 52, weight: .bold))
                .padding(.leading, Device_KTM.iPhone ? 51 : 102)
                .foregroundColor(.black)
            Spacer()
            Button {
                viewModel.showSetting = true
            } label: {
                Image("settings_Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Device_KTM.iPhone ? 32 : 64)
                    .padding(.trailing, Device_KTM.iPhone ? 19 : 38)
                    .foregroundColor(Color.black)
            }
        }
    }
    private var search: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
            
                .foregroundColor(viewModel.searchIsActive ?  .white : .black.opacity(0.04) )
                .cornerRadius(Device_KTM.iPhone ? 10 : 24)
            HStack(spacing: 5) {
                Image("search_image")
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, 10)
                    .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.12 : 0.078))
                Spacer()
            }
            TextField("", text: $viewModel.textForScrollURL, onEditingChanged: getFocus, onCommit: viewModel.doSerchInWebView)
                .font(.system(size: Device_KTM.iPhone ? 15 : 30, weight: .medium))
                .foregroundColor(.black)
                .padding(.leading, Device_KTM.iPhone ? 50: 80)
                .placeholder_KTM(when: viewModel.textForScrollURL.isEmpty) {
                    HStack(spacing: 5) {
                       Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.12 : 0.078))
                        Text(NSLocalizedString( "searchText", comment: ""))
                            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                            .font(.system(size: Device_KTM.iPhone ? 15 : 30, weight: .medium))
                        Spacer()
                    }
                }
                .onReceive(keyboardPublisherKTM) { isKeyboardVisible in
                    if  isKeyboardVisible {
                        withAnimation {
                            viewModel.keyboardWasOpened()
                        }
                    } else {
                        withAnimation {
                            viewModel.keyboardWasClosed()
                        }
                    }
                }
            Button {
                withAnimation {
                    UIApplication.shared.endEditing_KTM()
                    viewModel.textForScrollURL = ""
                }
            } label: {
                Image("exit_image")
                    .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                    .padding(.trailing, Device_KTM.iPhone ? 10 : 20)
            }
            .isVisible_KTM(!viewModel.textForScrollURL.isEmpty)
        }
        .frame(width: Device_KTM.iPhone ? ScreenSize_KTM.KTM_width - 48 : ScreenSize_KTM.KTM_width - 96, height:  Device_KTM.iPhone ? 44 : 88)
    }
    private var webView: some View {
        ZStack (alignment: .bottomTrailing) {
            Color.backgraungColor
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    WebviewScroll(manager: viewModel)
                        .frame(height: ScreenSize_KTM.KTM_height)
                }
            }
            .introspectScrollView { scrollView in
                scrollView.bounces = false
            }
            .blur(radius: viewModel.isShowAlertWebExitScrollView ? 5 : 0)
            
            Button {
                viewModel.scrollModeView = false
                viewModel.tapToCloseScrollSettings()
            } label: {
                HStack(spacing: 0) {
                    Image("left_image_KTM")
                        .foregroundColor(.white)
                        .scaleEffect(Device_KTM.iPhone ? 0.8 : 1.6)
                
                    Text(NSLocalizedString( "Back", comment: ""))
                        .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                        .foregroundColor(.white)
                        .offset(x: Device_KTM.iPhone ? -5 : 0)
                }
                .padding(Device_KTM.iPhone ? 5 : 18)
                .background(Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24))
            }
            .zIndex(1)
            .offset(x: -ScreenSize_KTM.KTM_width + (Device_KTM.iPhone ? 110 : 188), y: -ScreenSize_KTM.KTM_height / (Device_KTM.iPhone ? 1.2 : 1.15))
            
            VStack {
                ZStack {
                    if !viewModel.startScroll {
                        PlayButtonView(image: "play_image") {
                            withAnimation {
                                viewModel.tapToScrollSettings()
                            }
                        }
                    } else {
                        HStack {
                            Button {
                                viewModel.scrollSpeedIS()
                            } label: {
                                Text(viewModel.scrollSpeed.speedValue)
                                    .font(.system(size: Device_KTM.iPhone ? 16 : 32, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .padding(Device_KTM.iPhone ? 18 : 36)
                            .background(Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24))
                            
                            PlayButtonView(image: "stop_image") {
                                viewModel.tapToCloseScrollSettings()
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 24)
            .offset(y: viewModel.showKeyboard ? 400 : 0)
            .animation(nil)
            .zIndex(1)
        }
        .alert(isPresented: $viewModel.showNoInternetAlert) {
            Alert(title: Text("Error"),
                  message: Text(NSLocalizedString( "InternetError", comment: "")),
                  dismissButton: .default(Text("OK")))
        }
    }
}

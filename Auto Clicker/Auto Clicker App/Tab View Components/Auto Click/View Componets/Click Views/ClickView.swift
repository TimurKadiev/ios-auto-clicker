//
//  ClickView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 15.06.2023.
//

import SwiftUI
import Introspect
import WebKit
import UIKit

struct ClickView: View, KeyboardReadable_KTM {
    @EnvironmentObject var viewModel: AutoClickViewModel
    @GestureState private var dragOffset = CGSize.zero
    @GestureState private var dragClikOffset = CGSize.zero
    @GestureState private var dragClikSplitOffset = CGSize.zero
    var title: String
    var body: some View {
        ZStack {
            colorScheme
           
            backButton
           
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        if viewModel.webViwIsShowing == false {
                            clickMode
                        } else {
                            webView
                        }
                    }
                    .frame(width: ScreenSize_KTM.KTM_width)
                }
                .introspectScrollView { scrollView in
                    scrollView.bounces = false
                }
                
                if viewModel.isClickModeSplit {
                    splitClickMode
                }
            }
            
            WebButtonsView(viewModel: viewModel)
            
            ScrollView {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .frame(height: ScreenSize_KTM.KTM_height)
                        .onTapGesture {
                            viewModel.closeClickDisplayView()
                        }
                    if viewModel.doClickInSplitView {
                        ClickDisplayView(
                            textFieldMin: $viewModel.clickDisplayViewTextFieldMin,
                            textFieldSec: $viewModel.clickDisplayViewTextFieldSec,
                            textFieldCount: $viewModel.clickDisplayViewTextFieldCount,
                            focusedMin: $viewModel.focusedMin,
                            focusedSec: $viewModel.focusedSec,
                            focusedCount: $viewModel.focusedCount,
                            startClic: $viewModel.shouldStartClickOptionsSplit,
                            clickCounts: $viewModel.clickCounts, isRefresh: true) {
                                viewModel.starClickingSplit()
                            } closeAction: { viewModel.closeClickDisplayView() }
                            .padding(.horizontal, Device_KTM.iPhone ? 14 : 28)
                            .background(viewModel.focusedMin || viewModel.focusedSec || viewModel.focusedCount ? Color("lightGray").cornerRadius(Device_KTM.iPhone ? 20 : 40) : Color.white.cornerRadius(Device_KTM.iPhone ? 20 : 40))
                            .padding(.horizontal, Device_KTM.iPhone ? 14 : ScreenSize_KTM.KTM_width < 840 ? ScreenSize_KTM.KTM_width * 0.11 : ScreenSize_KTM.KTM_width * 0.14)
                            .shadow(color: Color.shadowColor, radius: 12)
                            .offset(y: viewModel.keybordShow() ? Device_KTM.iPhone ? -100 : -150 : 0)
                    } else {
                        ClickDisplayView(
                            textFieldMin: $viewModel.clickDisplayViewTextFieldMin,
                            textFieldSec: $viewModel.clickDisplayViewTextFieldSec,
                            textFieldCount: $viewModel.clickDisplayViewTextFieldCount,
                            focusedMin: $viewModel.focusedMin,
                            focusedSec: $viewModel.focusedSec,
                            focusedCount: $viewModel.focusedCount,
                            startClic: $viewModel.shouldStartClickOptionsSplit,
                            clickCounts: $viewModel.clickCounts, isRefresh: true) {
                                viewModel.starClicking()
                            } closeAction: { viewModel.closeClickDisplayView() }
                            .padding(.horizontal, Device_KTM.iPhone ? 14 : ScreenSize_KTM.KTM_width * 0.027)
                            .background(Color.white.cornerRadius(Device_KTM.iPhone ? 20 : 40))
                            .padding(.horizontal, Device_KTM.iPhone ? 14 : ScreenSize_KTM.KTM_width < 840 ? ScreenSize_KTM.KTM_width * 0.11 : ScreenSize_KTM.KTM_width * 0.14)
                            .shadow(color: .shadowColor, radius: 12)
                            .offset(y: viewModel.keybordShow() ? Device_KTM.iPhone ? -100 : -150 : 0)
                    }
                }
               
            }
            .edgesIgnoringSafeArea(.all)
            .opacity(viewModel.isShowClickDisplayView ? 1 : 0)
            .offset(y: viewModel.isShowClickDisplayView ? 0 : ScreenSize_KTM.KTM_height)
            .introspectScrollView { scrollView in
                scrollView.bounces = false
            }
            AlertWebExitClikView(viewModel: viewModel)

            ScrollView {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .frame(height: ScreenSize_KTM.KTM_height)
                        .onTapGesture {
                                viewModel.closeMultiClickDisplayView()
                        }
                    if viewModel.isClickModeMulti {
                        ClickDisplayMultiView(viewModel: viewModel)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .opacity(viewModel.isShowMultiClickDisplayView ? 1 : 0)
            .offset(y: viewModel.isShowMultiClickDisplayView ? 0 : ScreenSize_KTM.KTM_height)
            .introspectScrollView { scrollView in
                scrollView.bounces = false
            }
        }
        .onAppear {
            viewModel.slideCounterBottomButton = true
            viewModel.bottomScreenShow = true
            viewModel.topScreenShow = true
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(NSLocalizedString(viewModel.textForAlert, comment: "") ),
                  dismissButton: .default(Text("OK")))
        }
        .onTapGesture {
            UIApplication.shared.endEditing_KTM()
        }
    }
    func  getFocus ( focused : Bool ) { lazy var ktm = 135
        viewModel.showMenuPopUp = focused
    }

}

//struct ClickView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClickView(title: "")
//            .environmentObject(AutoClickViewModel())
//    }
//}

extension ClickView {
    @ViewBuilder
    private var colorScheme: some View {
        if !viewModel.webViwIsShowing {
            if viewModel.showMenuPopUp {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
            } else {
                Color.backgraungColor
                    .ignoresSafeArea()
            }
        }
    }
    
    private var searh: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .foregroundColor(viewModel.showMenuPopUp ? .white : .black.opacity(0.04))
                .cornerRadius(Device_KTM.iPhone ? 10 : 24)
            HStack(spacing: 5) {
                Image("search_image")
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, 10)
                    .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.12 : 0.078))
                Spacer()
            }
            TextField("", text: $viewModel.textForURL, onEditingChanged: getFocus, onCommit: viewModel.doSerchInWebView)
                .font(.system(size: Device_KTM.iPhone ? 15 : 30, weight: .medium))
                .foregroundColor(.black)
                .padding(.leading, Device_KTM.iPhone ? 50 :70)
                .placeholder_KTM(when: viewModel.textForURL.isEmpty) {
                    HStack(spacing: 5) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.12 : 0.078))
                        Text(NSLocalizedString("searchText", comment: ""))
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
                    viewModel.textForURL = ""
                }
            } label: {
                Image("exit_image")
            }
            .padding(.trailing, Device_KTM.iPhone ? 10 : 20)
            .isVisible_KTM(!viewModel.textForURL.isEmpty)
        }
        .frame(width: Device_KTM.iPhone ? ScreenSize_KTM.KTM_width - 48 : ScreenSize_KTM.KTM_width * 0.9 , height:  Device_KTM.iPhone ? 44 : 88)
    }
    private var clickMode: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack {
                Button {
                    viewModel.closeClickModeView()
                } label: {
                    Image("left_image_KTM")
                        .scaleEffect(Device_KTM.iPhone ? 1 : 1.5)
                        .padding(.leading, -10)
                }
                
                Spacer()
                Text(NSLocalizedString(title, comment: ""))
                    .font(.system(size: Device_KTM.iPhone ? 26 : 52, weight: .bold))
                    .padding(.trailing, 30)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.top, Device_KTM.iPhone ? 10 : 41)
            .foregroundColor(.black)
            
            searh
            
            Text(NSLocalizedString("title1", comment: ""))
                .font(.custom("Poppins-Medium", size: Device_KTM.iPhone ? 20 : 40))
                .foregroundColor(Color.black)
                .padding(.leading, Device_KTM.iPhone ? 0 : 48)
               
            LazyVGrid(columns: Device_KTM.iPhone ? Array(repeating: GridItem(spacing: 14), count: 2) : Array(repeating: GridItem(spacing: 24), count: 3), spacing: Device_KTM.iPhone ? 14 : 24) {
                ForEach(viewModel.fastLinkCollection) { cell in
                    Button {
                        viewModel.tapOnFastLink(cell)
                    } label: {
                        LinkCell( blackout: $viewModel.showMenuPopUp, selectId: $viewModel.idSelect, image: cell.image, name: cell.name, id: cell.id)
                    }
                }
            }
            .disabled(viewModel.showMenuPopUp)
            .padding(.top, -14)
            .padding(.bottom, ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.25 : 0.35))
        }
        .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
    }
    private var webView: some View {
        ZStack {
            Webview(manager: viewModel)
            if !viewModel.isClickModeMulti && !viewModel.isAutoRefreshMode {
                Image(viewModel.clickingNow ? "auto.click.active_image" : "auto.click_image")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 55)
                    .offset(x: min(max(viewModel.circleOffset.width + dragClikOffset.width, -ScreenSize_KTM.KTM_width / 2 + 22), ScreenSize_KTM.KTM_width / 2 + 5),
                            y: min(max(viewModel.circleOffset.height + dragClikOffset.height, -ScreenSize_KTM.KTM_height ), ScreenSize_KTM.KTM_height * 0.35 + 5 -
                                   (viewModel.isClickModeSplit ? (ScreenSize_KTM.KTM_height * 0.65 + 50 - viewModel.splitOffset.height) : 0)))
                    .gesture(
                        DragGesture()
                            .updating($dragClikOffset, body: { value, state, _ in
                                state = value.translation
                            })
                            .onEnded({ value in
                                viewModel.onEndedCircleOffset(value)
                            })
                    )
                    .onAppear {
                        viewModel.circleOffset.width = -ScreenSize_KTM.KTM_width * 0.3
                        if viewModel.isClickModeSplit {
                            viewModel.circleOffset.height = -ScreenSize_KTM.KTM_height * 0.25
                        }
                    }
            } else {
                ForEach($viewModel.multiClickModel) { $click in
                    ZStack {
                        Image(click.clickingNow ? "auto.click.active_image" : "auto.click_image")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 55)
                        ZStack {
                            Circle()
                                .frame(width: 25)
                                .foregroundColor(Color("darkBlue_KTM"))
                            Text(click.tapNumber.description)
                                .foregroundColor(Color("Orange"))
                                .bold()
                        }
                        .offset(x: 20, y: 15)
                    }
                    .offset(x: click.offsetWidth, y: click.offsetHeight)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                click.offsetWidth = value.location.x
                                click.offsetHeight = value.location.y
                            }
                    )
                }
            }
        }
        .frame(height: ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 1 : 1))
        .ignoresSafeArea()
    }
    private var splitClickMode: some View {
        ZStack(alignment: .topTrailing) {
            
            if !viewModel.webViwIsShowing {
                if viewModel.showMenuPopUp {
                    Color("lightGray")
                        .ignoresSafeArea()
                } else {
                    Color.backgraungColor
                        .ignoresSafeArea()
                }
            }
            
            PlayButtonView(image: viewModel.shouldStartClickOptions ? "stop_image" : "play_image") {
                viewModel.showClickDisplayView(false)
            }
            .offset(y: Device_KTM.iPhone ? -60: -120)
            .opacity(viewModel.slideCounterButton ? 1 : 0.0001)
            .disabled(!viewModel.webViwIsShowing && !viewModel.webViwIsShowingSlide)
            .disabled(viewModel.webViwIsShowing ? false : true)
            .zIndex(1)
            .padding(.trailing, Device_KTM.iPhone ? 24 : 48)
            
            VStack {
                Divider()
                    .frame(height: 2)
                    .background(Color.gray)
                
                VStack (spacing: 0) {
                    if viewModel.webViwIsShowingSlide == false {
                        HStack {
                            Text(NSLocalizedString("title1", comment: ""))
                                .font(.custom("Poppins-Medium", size: Device_KTM.iPhone ? 20 : 40))
                                .foregroundColor(Color.black)
                                .padding(.leading, Device_KTM.iPhone ? 20 : 48)
                            Spacer()
                        }
                        .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
                        
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: Device_KTM.iPhone ? Array(repeating: GridItem(spacing: 14), count: 2) : Array(repeating: GridItem(spacing: 24), count: 3), spacing: Device_KTM.iPhone ? 14 : 24) {
                                ForEach(viewModel.fastLinkCollection) { cell in
                                    Button {
                                        viewModel.tapOnFastLinkSlide(cell)
                                    } label: {
                                        LinkCell( blackout: $viewModel.showMenuPopUp, selectId: .constant(.init()), image: cell.image, name: cell.name, id: cell.id)
                                    }
                                }
                            }
                            .disabled(viewModel.showMenuPopUp)
                            .padding(.top)
                            .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
                            .padding(.bottom, ScreenSize_KTM.KTM_height * 0.27)
                        }
                        .frame(height: ScreenSize_KTM.KTM_height )
                    } else {
                        ZStack {
                            WebviewSplit(manager: viewModel)
                            
                            Image(viewModel.clickingNowSplit ? "auto.click.active_image" : "auto.click_image")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 55)
                                .offset(x: min(max(viewModel.circleSplitOffset.width + dragClikSplitOffset.width, -ScreenSize_KTM.KTM_width / 2 + 22), ScreenSize_KTM.KTM_width / 2 + 5),
                                        y: min(max(viewModel.circleSplitOffset.height + dragClikSplitOffset.height, -ScreenSize_KTM.KTM_height * 0.35), (ScreenSize_KTM.KTM_height ) - viewModel.splitOffset.height - 70))
                            
                                .gesture(
                                    DragGesture()
                                        .updating($dragClikSplitOffset, body: { value, state, _ in
                                            state = value.translation
                                        })
                                        .onEnded({ value in
                                            viewModel.onEndedcircleSplitOffset(value)
                                        })
                                )
                                .onAppear {
                                    viewModel.circleSplitOffset.width = -ScreenSize_KTM.KTM_width * 0.3
                                }
                        }
                        .frame(height: ScreenSize_KTM.KTM_height * 0.7)
                    }
                }
                
            }
            .frame(width: ScreenSize_KTM.KTM_width)
        }
        .background(Color.backgraungColor)
        .frame(height: ScreenSize_KTM.KTM_height / 3)
        .offset(y: viewModel.splitOffset.height + dragOffset.height)
        .onAppear {
            viewModel.splitOffset.height = ScreenSize_KTM.KTM_height * 0.4
        }
        .gesture(
            DragGesture()
                .updating($dragOffset, body: { value, state, _ in
                    state = value.translation
                })
                .onEnded({ value in
                    viewModel.onEndedSplitOffset(value)
                })
        )
    }
    private var backButton: some View {
        Button {
            viewModel.webViwIsShowing = false
            viewModel.webViwIsShowingSlide = false
            UIApplication.shared.endEditing_KTM()
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
        .offset(x: -ScreenSize_KTM.KTM_width / (Device_KTM.iPhone ? 3 : 2.7), y: -ScreenSize_KTM.KTM_height / (Device_KTM.iPhone ? 2.35 : 2.3))
        .isVisible_KTM(viewModel.webViwIsShowing)
    }
}

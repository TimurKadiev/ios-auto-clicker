//
//  WebButtonsView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 22.06.2023.
//

import SwiftUI

struct WebButtonsView: View {
    @ObservedObject var viewModel: AutoClickViewModel
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                if viewModel.isClickModeSingle || viewModel.isClickModeSplit {
                    HStack {
                        Spacer()
                        playButton
                    }
                    .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
                }
                
                if viewModel.isAutoRefreshMode && viewModel.webViwIsShowing {
                    HStack {
                        Spacer()
                        Button {
                            viewModel.showClickDisplayView(false)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .if(viewModel.isClickModeSplit) { $0.foregroundColor(viewModel.shouldStartClickOptionsSplit ? Color.white : Color.black)
                                    }
                                    .if(!viewModel.isClickModeSplit) { $0.foregroundColor(viewModel.shouldStartClickOptionsSplit ? Color.white : Color.black)
                                    }
                                    .cornerRadius(Device_KTM.iPhone ? 12 : 24)
                                if viewModel.isClickModeSplit {
                                    Image(viewModel.shouldStartClickOptionsSplit ? "stop_image" : "play_image")
                                        .foregroundColor(viewModel.shouldStartClickOptionsSplit ? .black : .white)
                                        .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                                } else {
                                    Image(viewModel.shouldStartClickOptions ? "stop_image" : "play_image")
                                        .foregroundColor(viewModel.shouldStartClickOptionsSplit ? .black : .white)
                                        .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                                }
                            }
                            .frame(width:  Device_KTM.iPhone ? 58 : 116, height:  Device_KTM.iPhone ? 58 : 116)
                        }
                    }
                    .padding(.horizontal, Device_KTM.iPhone ? 24 : 48)
                }
                
                if viewModel.isClickModeMulti {
                    HStack(spacing: 15) {
                        PlayButtonView(image: !viewModel.shouldStartClickOptionsMulti ? "play_image" : "stop_image", action: {viewModel.playOrStopMultiClicking()})
                            .disabled(viewModel.multiClickModel.isEmpty)
                        
                        HStack(spacing:0) {
                            PlayButtonView(image: "plus_icon_KTM", action: {viewModel.multiClickModelCreateElement()})
                            Rectangle()
                                .frame(width: 2, height: Device_KTM.iPhone ? 32 : 84)
                                .foregroundColor(.white.opacity(0.4))
                            PlayButtonView(image: "minusIcon", action: {viewModel.multiClickModelDelateLastElement()} )
                        }
                        .background(Color.black.cornerRadius( Device_KTM.iPhone ? 12 : 24))
                        
                        PlayButtonView(image: "settings_Icon", action: {viewModel.showMultiClickDisplayView()})
                        
                    }
                    .disabled(!viewModel.webViwIsShowing)
                }
            }
            .frame(width: ScreenSize_KTM.KTM_width)
        }
        
        .offset(y: viewModel.showKeyboard ? 400 : 0)
        .animation(nil)
    }
}

#Preview {
    WebButtonsView(viewModel: AutoClickViewModel())
}

extension WebButtonsView {
    private var playButton: some View {
        Button {
            if viewModel.isClickModeSplit {
                viewModel.showClickDisplayView(true)
            } else {
                viewModel.showClickDisplayView(false)
            }
        } label: {
            ZStack {
                Rectangle()
                    .if(viewModel.isClickModeSplit) { $0.foregroundColor(viewModel.shouldStartClickOptionsSplit ? Color.black : Color.black)
                    }
                    .if(!viewModel.isClickModeSplit) { $0.foregroundColor(viewModel.shouldStartClickOptionsSplit ? Color.black : Color.black)
                    }
                    .cornerRadius(Device_KTM.iPhone ? 12 : 24)
                if viewModel.isClickModeSplit {
                    Image(viewModel.shouldStartClickOptionsSplit ? "stop_image" : "play_image")
                        .foregroundColor(viewModel.shouldStartClickOptionsSplit ? .black : .white)
                        .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                } else {
                    Image(viewModel.shouldStartClickOptions ? "stop_image" : "play_image")
                        .foregroundColor(viewModel.shouldStartClickOptionsSplit ? .black : .white)
                        .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                }
            }
            .frame(width: Device_KTM.iPhone ? 58 : 116, height:  Device_KTM.iPhone ? 58 : 116)
        }
        .opacity(viewModel.slideCounterBottomButton ? 1 : 0)
        .disabled(!viewModel.webViwIsShowing && !viewModel.webViwIsShowingSlide)
        .disabled(viewModel.isClickModeSplit ? (viewModel.webViwIsShowingSlide ? false : true) : false )
    }
}

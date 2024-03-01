//
//  SplitClicModeView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 30.01.2024.
//

import SwiftUI

struct SplitClicModeView: View, KeyboardReadable_KTM {
    @EnvironmentObject var viewModel: AutoClickViewModel
    @GestureState private var dragOffset = CGSize.zero
    @GestureState private var dragClikOffset = CGSize.zero
    @GestureState private var dragClikSplitOffset = CGSize.zero
    var body: some View {
        ZStack {
            Color.backgraungColor
                .ignoresSafeArea()
                .padding(.top, 50)
            
            ScrollView {
                VStack {
                    Spacer()
                    PlayButtonView(image: viewModel.shouldStartClickOptions ? "stop_image" : "play_image") {
                        viewModel.showClickDisplayView(false)
                    }
                    .opacity(viewModel.slideCounterButton ? 1 : 0.0001)
                    .disabled(!viewModel.webViwIsShowing && !viewModel.webViwIsShowingSlide)
                    .disabled(viewModel.webViwIsShowing ? false : true)
                    Button {
                        viewModel.showClickDisplayView(false)
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(viewModel.shouldStartClickOptions ? Color("Orange") : Color("darkBlue_KTM"))
                                .cornerRadius(10)
                            
                            Text(viewModel.shouldStartClickOptions ? "Stop Click" : "Auto Click" )
                                .font(.custom("Poppins-Medium", size: 19))
                                .foregroundColor(.white)
                        }
                        .frame(width: 174, height: 50)
                    }
                    .opacity(viewModel.slideCounterButton ? 1 : 0.0001)
                    .disabled(!viewModel.webViwIsShowing && !viewModel.webViwIsShowingSlide)
                    .disabled(viewModel.webViwIsShowing ? false : true)
                    
                }
                
                VStack {
                    if viewModel.webViwIsShowingSlide == false {
                        VStack {
                            HStack {
                                Text(NSLocalizedString("title1", comment: ""))
                                    .font(.custom("Poppins-Medium", size: 18))
                                    .foregroundColor(Color.black)
                                    .padding(.leading, 20)
                                    .padding(.vertical)
                                Spacer()
                            }
                            LazyVGrid(columns: Device_KTM.iPhone ? Array(repeating: GridItem(spacing: 14), count: 2) : Array(repeating: GridItem(spacing: 24), count: 3), spacing: Device_KTM.iPhone ? 14 : 24) {
                                ForEach(viewModel.fastLinkCollection) { cell in
                                    Button {
                                        viewModel.tapOnFastLinkSlide(cell)
                                    } label: {
                                        LinkCell( blackout: $viewModel.showMenuPopUp, selectId: .constant(.init()), image: cell.image, name: cell.name, id: cell.id)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    } else {
                        ZStack {
                            WebviewSplit(manager: viewModel)
                            
                            Image(viewModel.clickingNowSplit ? "auto.click.active_image" : "auto.click_image")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 55)
                                .offset(x: min(max(viewModel.circleSplitOffset.width + dragClikSplitOffset.width, -ScreenSize_KTM.KTM_width / 2 + 22), ScreenSize_KTM.KTM_width / 2 + 5),
                                        y: min(max(viewModel.circleSplitOffset.height + dragClikSplitOffset.height, -ScreenSize_KTM.KTM_height * 0.35 - 5), (ScreenSize_KTM.KTM_height * 0.35 + 5) - viewModel.splitOffset.height - 70))
                            
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
        .frame(height: ScreenSize_KTM.KTM_height / 2)
        .onAppear {
            viewModel.splitOffset.height = ScreenSize_KTM.KTM_height * 0.2
        }
    }
}

#Preview {
    SplitClicModeView()
        .environmentObject(AutoClickViewModel())
}

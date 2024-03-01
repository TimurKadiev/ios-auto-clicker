//
//  TransactionView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 23.01.2024.
//

import SwiftUI
import AVFoundation

struct TransactionView: View {
    @State private var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    @State var isPlaying = false
    let isShowExitButton: Bool
    let action: EmptyBlock
    let closeAction: EmptyBlock
    
    private var player: AVPlayer {
        guard let path = Bundle.main.url(forResource: "Short3 iPhone", withExtension: "mp4") else {
            fatalError("Видео не найдено в Asset Catalog")
        }
        return AVPlayer(url: path)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VideoBackgroundView(isPlaying: $isPlaying, player: player)
                .ignoresSafeArea()
                .disabled(true)
                .onDisappear {
                    isPlaying = false
                }
            Rectangle()
                .frame(height: ScreenSize_KTM.KTM_height / 2.5)
                .foregroundColor(.clear)
                .background(LinearGradient(colors: [.black, .clear], startPoint: .center, endPoint: .top))
                
            VStack(alignment: .leading, spacing: 13) {
                restorButton
                
                Spacer()
            
                title
        
                description
                    .onAppear {
                        print(Locale.current.identifier)
                    }
                                
                if Locale.current.identifier.hasPrefix("en") {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: ScreenSize_KTM.KTM_width * 0.04)
                        VStack(alignment: .leading) {
                            Text("START 3 DAYS FOR FREE, THEN $4.99/7 DAYS")
                                .font(
                                    Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24)
                                        .weight(.bold)
                                )
                            Text("Cancel at any time")
                                .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24)
                                    .weight(.bold))
                        }
                    }
                }

                description
                ScrollView {
                    HStack {
                        Spacer()
                        
                        Link(destination: URL(string: Config_KTM.policyLink)!, label: {
                            Image(systemName: "star.fill")
                            
                            Text(NSLocalizedString("PaymentID", comment: ""))
                                .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24).weight(.bold)
                                )
                        })
                        
                        Spacer()
                    }
                    .multilineTextAlignment(.center)
                    
                    ContinueButton_KTM(action: action)
                    VStack(spacing: 35) {
                        
                        HStack {
                            Link(destination: URL(string: Config_KTM.policyLink)!, label: {
                                Text(NSLocalizedString("PrivacyID", comment: ""))
                                    .underline()
                                    .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24))
                            })
                            
                            Spacer()
                            
                            Link(destination: URL(string: Config_KTM.termsLink)!, label: {
                                Text(NSLocalizedString("TermsID", comment: ""))
                                    .underline()
                                    .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24))
                            })
                        }
                        .padding(.horizontal, 5)
                        
                        Text(NSLocalizedString("SubscriptionText", comment: ""))
                            .font(Font.custom("Poppins-Regular", size: Device_KTM.iPhone ? 10 : 20))
                    }
                }
                .frame(height: ScreenSize_KTM.KTM_height / 8)
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .padding(.top, 50)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea()
        .onAppear {
            isPlaying = true
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
}

#Preview {
    TransactionView(isShowExitButton: true, action: ({}), closeAction: ({}))
}

extension TransactionView {
    private var restorButton: some View  {
        VStack {
            HStack {
                if isShowExitButton {
                    Button {
                        closeAction()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("exit_image")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Text(NSLocalizedString("Restore", comment: ""))
                        .font(.system(size: Device_KTM.iPhone ? 12 : 28))
                }
            }
            Spacer()
        }
        
    }
    private var title: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(NSLocalizedString("Tap", comment: ""))
                .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 24 : 48).weight(.black))
            + Text("CONTINUE")
                .font(Font.custom("Gilroy", size: 32).weight(.black))
                .foregroundColor(Color(red: 0.62, green: 0.89, blue: 1))
            + Text(NSLocalizedString("to", comment: ""))
                .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 24 : 48).weight(.black))
            Text("text text text text")
                .font(Font.custom("Gilroy", size: Device_KTM.iPhone ? 24 : 48).weight(.bold))
                
        }
        .shadow(color: .black.opacity(0.4), radius: 4, y: 2)
    }
    private var description: some View {
        HStack {
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: ScreenSize_KTM.KTM_width * 0.04)
            VStack(alignment: .leading) {
                Text("text text text text text text text text text")
                    .textCase(.uppercase)
                    .font(
                    Font.custom("Gilroy", size: Device_KTM.iPhone ? 12 : 24)
                    .weight(.bold)
                    )
                Text("text text text text text text text text")
                    .font(
                    Font.custom("Gilroy", size: Device_KTM.iPhone ? 10 : 22)
                    .weight(.bold)
                    )
            }
        }
    }
}

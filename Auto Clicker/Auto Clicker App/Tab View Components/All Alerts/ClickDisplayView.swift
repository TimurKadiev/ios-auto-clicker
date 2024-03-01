//
//  ClickDisplayView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 19.06.2023.
//

import SwiftUI

struct ClickDisplayView: View {
    @Binding var textFieldMin: String
    @Binding var textFieldSec: String
    @Binding var textFieldCount: String
    @Binding var focusedMin: Bool
    @Binding var focusedSec: Bool
    @Binding var focusedCount: Bool
    @Binding var startClic: Bool
    @Binding var clickCounts: String
    let isRefresh: Bool
    var action: EmptyBlock
    var closeAction: EmptyBlock
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if isRefresh {
                Button {
                    closeAction()
                } label: {
                    Image("exit_image")
                        .scaleEffect(Device_KTM.iPhone ? 1 : 2)
                }
                .zIndex(1)
                .padding(.vertical, Device_KTM.iPhone ? 10 : 20)
            }
            
            VStack(spacing: Device_KTM.iPhone ? 56 : 122) {
                Text(clickCounts)
                    .font(.system(size: Device_KTM.iPhone ? 112 : 224, weight: .medium))
                    .foregroundColor(.black)
                    .frame(height: ScreenSize_KTM.KTM_height * (Device_KTM.iPhone ? 0.12 : 0.117))
                    .padding(.top, ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.148 : 0.13))
                   
                
                VStack(alignment: .leading) {
                    HStack (spacing: Device_KTM.iPhone ? ScreenSize_KTM.KTM_width * 0.016 : ScreenSize_KTM.KTM_width * 0.032) {
                        Text(NSLocalizedString("timeID", comment: ""))
                            .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        Spacer()
                                        
                        AutoCounterTextField(clickDisplayViewTextFieldMin: $textFieldMin, focused: $focusedMin, text: "min")
                        
                        AutoCounterTextField(clickDisplayViewTextFieldMin: $textFieldSec, focused: $focusedSec, text: "sec")
                        
                    }
                    HStack(spacing: ScreenSize_KTM.KTM_width * (Device_KTM.iPhone ? 0.058 : 0.043 )) {
                        Text(NSLocalizedString("countID", comment: "") )
                            .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                            .foregroundColor(.black)
                            .lineLimit(1)
                        
                        ZStack {
                            if focusedCount {
                                Color.white.cornerRadius(Device_KTM.iPhone ? 12 : 24)
                            } else {
                                Color.black.opacity(0.04)
                                    .cornerRadius(Device_KTM.iPhone ? 12 : 24)
                            }
                            
                            TextField("0", text: $textFieldCount, onEditingChanged: getFocus)
                                .multilineTextAlignment(.center)
                                .font(.system(size: Device_KTM.iPhone ? 20 : 40, weight: .medium))
                                .foregroundColor(.black)
                                .keyboardType(.numberPad)
                        }
                        .frame(height: Device_KTM.iPhone ? 44 : 88)
                    }
                }
                .onTapGesture {
                    UIApplication.shared.endEditing_KTM()
                }
                Button {
                    action()
                } label: {
                    HStack {
                        Image(startClic ? "stop_image" : "play_image")
                            .resizable()
                            .scaledToFit()
                            .frame(height: ScreenSize_KTM.KTM_height * 0.058)
                            .padding(.vertical, Device_KTM.iPhone ? 9 : 18)
                        Text(startClic ? "STOP" : "START")
                            .font(Font.custom("SF Pro Display", size: Device_KTM.iPhone ? 20 : 40).weight(.medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black.cornerRadius(Device_KTM.iPhone ? 12 : 24))
                    .padding(.bottom, Device_KTM.iPhone ? 14 : 28)
                    .contentShape(Rectangle())
                }
                
            }
            .onTapGesture {
                UIApplication.shared.endEditing_KTM()
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing_KTM()
        }
    }
    func getFocus ( focused : Bool ) { lazy var ref1 = 111.111
        focusedCount = focused
    }
}

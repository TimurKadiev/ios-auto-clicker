//
//  AlertView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 25.06.2023.
//

import Foundation
import SwiftUI

struct AlertWebExitClikView: View {
    @ObservedObject var viewModel: AutoClickViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.5)
                .onTapGesture {
                    viewModel.closeAlertWebExitClikView()
                }
            Rectangle()
                .foregroundColor(Color("525ECC_KTM_Blue"))
                .cornerRadius(20)
                .frame(width: 342, height: 202)

            VStack {
                Text("Notification")
                    .font(.custom("Poppins-SemiBold", size: 17))
                    .foregroundColor(.white)

                Text("Stop Auto \(viewModel.isAutoRefreshMode ? "refresh" : "click") and \n go to homepage?")
                    .font(.custom("Poppins-Regular", size: 15))
                    .foregroundColor(.white)
                    .padding()

                HStack {
                    Button {
                        viewModel.doExitWeb()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.black)
                                .cornerRadius(24)
                                .frame(width: 128, height: 50)
                            
                            Text("Yes")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    Button {
                        viewModel.closeAlertWebExitClikView()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("Orange"))
                                .cornerRadius(24)
                                .frame(width: 128, height: 50)
                            
                            Text("No")
                                .font(.custom("Poppins-Regular", size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .offset(y: viewModel.isShowAlertWebExitClikView ? 0 : ScreenSize_KTM.KTM_height / 2)
        .opacity(viewModel.isShowAlertWebExitClikView ? 1 : 0)
    }
}

#Preview {
    AlertWebExitClikView(viewModel: AutoClickViewModel())
}

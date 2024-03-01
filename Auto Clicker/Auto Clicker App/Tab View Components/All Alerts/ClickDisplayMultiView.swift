//
//  ClickDisplayView.swift
//  Auto Clicker
//
//  Created by Igor Kononov on 19.06.2023.
//

import SwiftUI

struct ClickDisplayMultiView: View {
    @ObservedObject var viewModel: AutoClickViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                viewModel.closeMultiClickDisplayView()
            } label: {
                Image("exit_image")
                    .scaleEffect(Device_KTM.iPhone ? 1 : 1)
            }
            .zIndex(1)
            .padding(.vertical, Device_KTM.iPhone ? 10 : 10)
            .padding(.horizontal, 5)
            
            VStack {
                Text(NSLocalizedString("Repeat", comment: "") )
                    .font(.system(size: 20 , weight: .bold))
                    .padding(.vertical)
                    .foregroundColor(.black)
                
                TextField("0", text: $viewModel.multiRepeat)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 112, weight: .medium))
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
                    .keyboardType(.numberPad)

                ScrollView {
                    ForEach($viewModel.multiClickModel) { $click in
                        
                        HStack {
                            VStack {
                                Text(NSLocalizedString("Tap \(click.tapNumber):", comment: "") )
                                    .foregroundColor(Color.black)
                                    .font(.custom("Poppins-Bold", size: 15))
                                Spacer()
                                Text(NSLocalizedString("Delay time=", comment: ""))
                                    .frame(width: 90)
                                    .foregroundColor(Color.black)
                                    .font(.custom("Poppins-Regular", size: 15))
                                Spacer()
                            }
                            Spacer()
                            
                            ZStack {
                                Color.black.opacity(0.04)
                                    .cornerRadius(20)
                                
                                TextField("", text: $click.min)
                                    .multilineTextAlignment(.center)
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal)
                                    .keyboardType(.numberPad)
                            }
                            .frame(width: 66, height: 47)
                            
                            Text(NSLocalizedString("min", comment: ""))
                                .foregroundColor(Color.black)
                                .font(.custom("Poppins-Regular", size: 15))
                            Spacer()
                            ZStack {
                                Color.black.opacity(0.04)
                                    .cornerRadius(20)
                                
                                TextField("", text: $click.sec)

                                    .multilineTextAlignment(.center)
                                    .font(.custom("Poppins-Regular", size: 15))
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal)
                                    .keyboardType(.numberPad)
                            }
                            .frame(width: 66, height: 47)
                            
                            Text(NSLocalizedString("sec", comment: ""))
                                .foregroundColor(Color.black)
                                .font(.custom("Poppins-Regular", size: 15))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                    Spacer()
                    
                    
                }
                Button {
                    viewModel.saveMultiClickOptions()
                } label: {
                    HStack {
                        Image("save_image")
                        
                        Text(NSLocalizedString("SAVE", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 20))
                    }
                    
                }
                .frame(width: 308, height: 49)
                .background(Color.black.cornerRadius(20))
                .padding(.bottom)
            }
            .padding(.top, 30)
        }
        .frame(width: 343, height: 458)
        .background(Color.white.cornerRadius(20))
    }
}

    
struct ClickDisplayMultiView_Previews: PreviewProvider {
    static var previews: some View {
        ClickDisplayMultiView(viewModel: AutoClickViewModel())
    }
}

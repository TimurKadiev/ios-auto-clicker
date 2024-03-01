//
//  SubscriptionStartView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 24.01.2024.
//

import SwiftUI
import AVFoundation

struct SelectionSubscriptionView: View {
    @State private var selectedCards: [Int] = []
    @State private var scale: CGFloat = 1.0
    @State var player: AVPlayer
    @Binding var isPlaying: Bool
    var action: EmptyBlock
   
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VideoBackgroundView(isPlaying: $isPlaying, player: player)
                .ignoresSafeArea()
                .disabled(true)
            
            Rectangle()
                .frame(height: ScreenSize_KTM.KTM_height / 2.3)
                .foregroundColor(.clear)
                .background(LinearGradient(colors: [.black, .clear,], startPoint: .center, endPoint: .top))
            
            VStack (spacing: 16) {
                Spacer()
                
                Text("TEXT TEXT TEXT")
                    .font(
                        Font.custom("Gilroy", size: Device_KTM.iPhone ? 24 : 48)
                            .weight(.black)
                    )
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 4, y: 2)
                
                Text("TEXT TEXT TEXT TEXT")
                    .font(
                        Font.custom("Gilroy", size: Device_KTM.iPhone ? 24 : 48)
                            .weight(.black)
                    )
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.4), radius: 4, y: 2)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10 ) {
                        ForEach(0..<10) { index in
                            CardView(isSelected: selectedCards.contains(index))
                                .onTapGesture {
                                    if self.selectedCards.contains(index) {
                                        self.selectedCards.removeAll(where: { $0 == index })
                                    } else {
                                        self.selectedCards.append(index)
                                    }
                                }
                        }
                    }
                    .padding(.leading, ScreenSize_KTM.KTM_width * 0.05)
                }
                
                ContinueButton_KTM(action: action)
            }
            .padding(.bottom, 20)
            
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    SelectionSubscriptionView(player: AVPlayer(url: Bundle.main.url(forResource: "Short3 iPhone", withExtension: "mp4")!), isPlaying: .constant(false), action: ({}))
}

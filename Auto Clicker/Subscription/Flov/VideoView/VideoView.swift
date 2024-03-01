//
//  VideoView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 20.02.2024.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoBackgroundView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    var player: AVPlayer
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if isPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
}

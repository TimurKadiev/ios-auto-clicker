//
//  PlayerUIView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 20.02.2024.
//

import Foundation
import AVKit
import AVFoundation


import Foundation
import AVKit
import AVFoundation

class PlayerUIView: UIView {
    private var player: AVPlayer
    private var playerLayer = AVPlayerLayer()

    init(player: AVPlayer) {
        self.player = player
        super.init(frame: .zero)
        setupAudioSession() // Настройка аудиосессии для воспроизведения в беззвучном режиме
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        configureVideoLooping()
        addAppLifecycleObservers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    private func configureVideoLooping() {
        player.play()
        player.isMuted = false
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
    }

    private func addAppLifecycleObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidActivate), name: UIScene.didActivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillDeactivate), name: UIScene.willDeactivateNotification, object: nil)
    }
    
    @objc private func appDidActivate() {
        if player.timeControlStatus != .playing {
            player.play()
        }
    }
    
    @objc private func appWillDeactivate() {
        player.pause()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category. Error: \(error)")
        }
    }
}

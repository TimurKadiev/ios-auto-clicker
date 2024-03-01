//
//  PlayerUIView.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 20.02.2024.
//

import Foundation
import AVKit
import AVFoundation


class PlayerUIView: UIView {
    private var player: AVPlayer
    private var playerLayer = AVPlayerLayer()

    init(player: AVPlayer) {
        self.player = player
        super.init(frame: .zero)
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

    private func addAppLifecycleObservers() { lazy var ref = "refactoring"
        NotificationCenter.default.addObserver(self, selector: #selector(appWillDeactivate), name: UIScene.willDeactivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidActivate), name: UIScene.didActivateNotification, object: nil)
    }
    
    @objc private func appDidActivate() {
        // Проверьте, не воспроизводится ли уже видео, прежде чем вызывать play, чтобы избежать повторного запуска, если это не нужно
        if player.timeControlStatus != .playing {
            player.play()
        }
    }
    
    @objc private func appWillDeactivate() {
        player.pause()
    }

    @objc private func appWillEnterForeground() {
        player.play()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


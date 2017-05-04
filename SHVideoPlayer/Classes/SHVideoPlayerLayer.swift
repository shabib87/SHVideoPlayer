//
//  SHVideoPlayerLayer.swift
//  SHVideoPlayer
//
//  Created by Shabib Hossain on 11/14/16.
//
//

import UIKit
import AVFoundation

public class SHVideoPlayerLayer: UIView {
    
    private var playerLayer: AVPlayerLayer?

    public var videoGravity = AVLayerVideoGravityResizeAspect {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    public var player: AVPlayer?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.videoGravity = "AVLayerVideoGravityResizeAspect"
        self.playerLayer?.frame  = self.bounds
    }
    
    public func resetPlayer() {
        self.player?.replaceCurrentItem(with: nil)
        self.player = nil
        self.playerLayer?.removeFromSuperlayer()
    }
    
    public func startPreparingForDeinit() {
        self.resetPlayer()
    }
    
    public func configPlayer(){
        self.resetPlayer()
        self.player = AVPlayer()
        self.playerLayer = AVPlayerLayer(player: player)
        guard let _playerLayer = playerLayer else { print("SHVideoPlayerLayer: configPlayer():- player layer is nil"); return }
        _playerLayer.videoGravity = videoGravity
        self.layer.insertSublayer(_playerLayer, at: 0)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

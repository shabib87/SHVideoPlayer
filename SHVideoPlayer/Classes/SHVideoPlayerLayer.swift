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
    private var lastPlayerItem: AVPlayerItem?
    
    public var videoURL: URL! {
        didSet { onSetVideoURL() }
    }
    
    public var videoGravity = AVLayerVideoGravityResizeAspect {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    public var playerItem: AVPlayerItem? {
        didSet {
            onPlayerItemChange()
        }
    }
    
    lazy var player: AVPlayer? = {
        if let item = self.playerItem {
            return  AVPlayer(playerItem: item)
        }
        return nil
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.videoGravity = "AVLayerVideoGravityResizeAspect"
        self.playerLayer?.frame  = self.bounds
    }
    
    public func resetPlayer() {
        self.playerLayer?.removeFromSuperlayer()
        self.player?.replaceCurrentItem(with: nil)
        self.player = nil
    }
    
    public func startPreparingForDeinit() {
        self.playerItem = nil
        self.resetPlayer()
    }
    
    private func onSetVideoURL() {
        self.configPlayer()
    }
    
    private func configPlayer(){
        self.playerItem = AVPlayerItem(url: videoURL)
        guard let _playerItem = playerItem else { print("player item is nil"); return }
        self.player = AVPlayer(playerItem: _playerItem)
        self.playerLayer = AVPlayerLayer(player: player)
        guard let _playerLayer = playerLayer else { print("player layer is nil"); return }
        _playerLayer.videoGravity = videoGravity
        self.layer.insertSublayer(_playerLayer, at: 0)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func onPlayerItemChange() {
        lastPlayerItem = playerItem
    }
}

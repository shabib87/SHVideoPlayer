//
//  SHVideoPlayerLayer.swift
//  SHVideoPlayer
//
//  Created by Shabib Hossain on 11/14/16.
//
//

import UIKit
import AVFoundation

open class SHVideoPlayerLayer: UIView {
    
    fileprivate var playerLayer: AVPlayerLayer?
    fileprivate var lastPlayerItem: AVPlayerItem?
    
    open var videoURL: URL! {
        didSet { onSetVideoURL() }
    }
    
    open var videoGravity = AVLayerVideoGravityResizeAspect {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    open var playerItem: AVPlayerItem? {
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.videoGravity = "AVLayerVideoGravityResizeAspect"
        self.playerLayer?.frame  = self.bounds
    }
    
    open func resetPlayer() {
        self.playerLayer?.removeFromSuperlayer()
        self.player?.replaceCurrentItem(with: nil)
        self.player = nil
    }
    
    open func prepareToDeinit() {
        self.playerItem = nil
        self.resetPlayer()
    }
    
    fileprivate func onSetVideoURL() {
        self.configPlayer()
    }
    
    fileprivate func configPlayer(){
        self.playerItem = AVPlayerItem(url: videoURL)
        self.player = AVPlayer(playerItem: playerItem!)
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer!.videoGravity = videoGravity
        self.layer.insertSublayer(playerLayer!, at: 0)
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    fileprivate func onPlayerItemChange() {
        lastPlayerItem = playerItem
    }
}

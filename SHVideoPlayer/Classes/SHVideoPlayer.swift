//
//  SHVideoPlayer.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import Foundation
import SnapKit
import AVFoundation

open class SHVideoPlayer: UIView {
    
    open var tapGesture: UITapGestureRecognizer!
    open var videoGravity = AVLayerVideoGravityResizeAspect {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    fileprivate var playerControl: SHVideoPlayerControl!
    fileprivate var playerLayer: SHVideoPlayerLayer!
    fileprivate var playerScrubber: SHVideoPlayerScrubber!
    
    fileprivate var customPlayerControl: SHVideoPlayerControl?
    
    fileprivate var playerControlsAreVisible = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initUI()
    }
    
    public convenience init (customPlayerControl: SHVideoPlayerControl?) {
        self.init(frame:CGRect.zero)
        self.initUI()
    }
    
    public convenience init() {
        self.init(customPlayerControl:nil)
    }
    
    fileprivate func initUI() {
        self.preparePlayerControl()
        self.preparePlayer()
        self.preparePlayerScrubber()
    }
    
    fileprivate func preparePlayerControl() {
        if let customView = customPlayerControl {
            playerControl = customView
        } else {
            playerControl =  SHVideoPlayerDefaultControl()
        }
        self.addSubview(playerControl.controlView)
        playerControl.updateUI(isFullScreen)
        playerControl.controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func preparePlayer() {
        playerLayer = SHVideoPlayerLayer()
        playerLayer!.videoGravity = videoGravity
        insertSubview(playerLayer!, at: 0)
        playerLayer!.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.layoutIfNeeded()
    }
    
    fileprivate func preparePlayerScrubber() {
        // TODO: fix crash
//        self.playerScrubber = SHVideoPlayerScrubber(with: playerLayer.player!, slider: playerControl.timeSlider!, currentTimeLabel: playerControl.currentTimeLabel!, durationLabel: playerControl.durationLabel!, remainingTimeLabel: playerControl.remainingTimeLabel!, playPauseButton: playerControl.playButton!)
    }
    
    @objc fileprivate func tapGestureTapped(_ sender: UIGestureRecognizer) {
        if self.playerControlsAreVisible {
            playerControl.hidePlayerUIComponents()
        } else {
            playerControl.showPlayerUIComponents()
        }
        self.playerControlsAreVisible = !self.playerControlsAreVisible;
    }
    
    deinit {
        
    }
}

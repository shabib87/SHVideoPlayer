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
    
    fileprivate var playerControl: SHVideoPlayerControl!
    fileprivate var playerLayer: SHVideoPlayerLayer!
    fileprivate var playerScrubber: SHVideoPlayerScrubber!
    
    fileprivate var customPlayerControl: SHVideoPlayerControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.playerControl = SHVideoPlayerDefaultControl()
        self.preparePlayer()
        self.playerScrubber = SHVideoPlayerScrubber(with: playerLayer.player!, slider: playerControl.timeSlider!, currentTimeLabel: playerControl.currentTimeLabel!, durationLabel: playerControl.durationLabel!, remainingTimeLabel: playerControl.remainingTimeLabel!, playPauseButton: playerControl.playButton!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.playerControl = SHVideoPlayerDefaultControl()
    }
    
    public convenience init (customControllView: SHVideoPlayerControl?) {
        self.init(frame:CGRect.zero)
        self.playerControl = customControllView
    }
    
    public convenience init() {
        self.init(customControllView:nil)
    }
    
    fileprivate func preparePlayerControl() {
        self.backgroundColor = UIColor.black
        if let customView = customControllView {
            controlView = customView
        } else {
            controlView =  BMPlayerControlView()
        }
        
        addSubview(controlView.getView)
        controlView.updateUI(isFullScreen)
        controlView.delegate = self
        controlView.getView.snp.makeConstraints { (make) in
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
    
    deinit {
        
    }
}

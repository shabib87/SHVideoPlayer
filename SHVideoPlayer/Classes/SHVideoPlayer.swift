//
//  SHVideoPlayer.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import Foundation
import SnapKit

open class SHVideoPlayer: UIView {
    
    open var tapGesture: UITapGestureRecognizer!
    fileprivate var playerControl: SHVideoPlayerControl!
    fileprivate var playerLayer: SHVideoPlayerLayer!
    fileprivate var playerScrubber: SHVideoPlayerScrubber!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.playerControl = SHVideoPlayerDefaultControl()
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
    
    deinit {
        
    }
}

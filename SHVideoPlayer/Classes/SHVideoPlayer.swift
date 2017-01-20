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
    fileprivate var playerControllerView: SHVideoPlayerControlable!
    fileprivate var playerLayer: SHVideoPlayerLayerView!
    fileprivate var playerScrubber: SHVideoPlayerScrubber!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.playerControllerView = SHVideoPlayerWithDefaultControlsView()
        self.playerScrubber = SHVideoPlayerScrubber(with: playerLayer.player!, slider: playerControllerView.playerTimeSlider!, currentTimeLabel: playerControllerView.playerCurrentTimeLabel!, durationLabel: playerControllerView.playerTotalTimeLabel!, remainingTimeLabel: playerControllerView.playerRemainingTimeLabel!, playPauseButton: playerControllerView.playerPlayButton!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.playerControllerView = SHVideoPlayerWithDefaultControlsView()
    }
    
    public convenience init (customControllView: SHVideoPlayerControlable?) {
        self.init(frame:CGRect.zero)
        self.playerControllerView = customControllView
    }
    
    public convenience init() {
        self.init(customControllView:nil)
    }
    
    deinit {
        
    }
}

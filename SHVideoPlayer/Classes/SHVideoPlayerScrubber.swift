//
//  SHVideoPlayerScrubber.swift
//  Pods
//
//  Created by Shabib Hossain on 11/16/16.
//
//

import UIKit
import AVFoundation

class SHVideoPlayerScrubber: NSObject {
    
    var slider: UISlider! { get { return slider } set { setSliderTap() } }
    var currentTimeLabel: UILabel!
    var durationLabel: UILabel!
    var remainingTimeLabel: UILabel!
    
    var player: AVPlayer! { get { return player }
        set {
            player.pause()
            removeTimeObserver()
            // TODO: set nominalFrameRateForPlayer
            frameDuration = 1 / framesPerSecond
            // set time observer
            // seld updateCurrentTimeLabel
            var duration = player.currentItem?.duration
            if !CMTIME_IS_VALID(duration!) || CMTIME_IS_INDEFINITE(duration!) {
                player.currentItem?.addObserver(self, forKeyPath: "duration", options: .new, context: nil)
            }
        }
    }
    
    fileprivate var playAfterDrag: Bool!
    fileprivate var timeObserver: AnyObject!
    fileprivate var frameDuration: Float!
    fileprivate var framesPerSecond: Float!
    
    fileprivate func setSliderTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sliderTapAction))
        slider.addGestureRecognizer(gesture)
    }
    
    fileprivate func removeTimeObserver() {
        if timeObserver != nil {
            player.removeTimeObserver(timeObserver)
        }
        timeObserver = nil
    }
    
    @objc fileprivate func sliderTapAction(gesture: UITapGestureRecognizer) {
        
    }
}

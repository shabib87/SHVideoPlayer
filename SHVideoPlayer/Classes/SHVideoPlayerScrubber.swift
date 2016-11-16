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
    
    var slider: UISlider? { get {
            return slider
        } set {
            setSliderTapAction()
            setSliderValueChangeAction()
        }
    }
    var currentTimeLabel: UILabel?
    var durationLabel: UILabel?
    var remainingTimeLabel: UILabel?
    
    var player: AVPlayer! { get { return player }
        set {
            self.player.pause()
            removeTimeObserver()
            self.framesPerSecond = nominalFrameRateForPlayer()
            setupTimeObserver()
            updateCurrentTimeLabelWithTime(time: 0)
            var duration = self.player.currentItem?.duration
            if !CMTIME_IS_VALID(duration!) || CMTIME_IS_INDEFINITE(duration!) {
                self.player.currentItem?.addObserver(self, forKeyPath: "duration", options: .new, context: nil)
            }
        }
    }
    
    fileprivate var playAfterDrag: Bool = true
    fileprivate var timeObserver: Any?
    fileprivate var framesPerSecond: Float = 0.0
    
    fileprivate func setSliderTapAction() {
        if self.slider == nil { return }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sliderTapAction))
        slider?.addGestureRecognizer(gesture)
    }
    
    fileprivate func setSliderValueChangeAction() {
        slider?.addTarget(self, action: #selector(sliderValueChangeAction), for: .valueChanged)
    }
    
    fileprivate func setupTimeObserver() {
        if framesPerSecond > 0 {
            weak var weakSelf = self
            let seconds = Float64(1 / framesPerSecond)
            let interval = CMTimeMakeWithSeconds(seconds, Int32(NSEC_PER_SEC))
            let mainQueue = DispatchQueue.main
            timeObserver = self.player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { (time: CMTime) in
                weakSelf?.playerTimeChanged()
            })
        }
    }
    
    fileprivate func removeTimeObserver() {
        if timeObserver != nil {
            self.player.removeTimeObserver(timeObserver)
        }
        timeObserver = nil
    }
    
    fileprivate func nominalFrameRateForPlayer() -> Float{
        var track: AVAssetTrack? = nil
        let tracks = self.player.currentItem?.asset.tracks(withMediaType: AVMediaTypeVideo)
        if tracks?.count != 0 {
            track = tracks?[0]
        }
        return track!.nominalFrameRate
    }
    
    fileprivate func updateCurrentTimeLabelWithTime(time: TimeInterval) {
        if self.currentTimeLabel == nil { return }
        self.currentTimeLabel?.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func updateDurationLabelWithTime(time: TimeInterval) {
        if self.durationLabel == nil { return }
        self.durationLabel?.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func updateRemainingTimeLabelWithTime(time: TimeInterval) {
        if self.remainingTimeLabel == nil { return }
        self.remainingTimeLabel?.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func timecodeForTimeInterval(time: TimeInterval) -> String {
        let sign = time < 0 ? "-" : ""
        var timeCode = ""
        var absTime = Int(abs(time))
        var hours = absTime / 60 / 24
        var minutes = (absTime - hours * 24) / 60
        var seconds = (absTime - hours * 24) - minutes * 60
        if hours > 0 {
            timeCode = String(format: "\(sign)%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            timeCode = String(format: "\(sign)%02d:%02d", minutes, seconds)
        }
        return timeCode
    }
    
    fileprivate func playerTimeChanged() {
        if self.player.currentItem == nil { return }
        let secondsElapsed = CMTimeGetSeconds(self.player.currentItem!.currentTime())
        var duratoinInSeconds = 0.0
        var ratio = 0.0
        if CMTIME_IS_VALID((self.player.currentItem?.duration)!) && !CMTIME_IS_INDEFINITE((self.player.currentItem?.duration)!) {
           duratoinInSeconds = CMTimeGetSeconds((self.player.currentItem?.duration)!)
        }
        
        if duratoinInSeconds > 0 {
            ratio = secondsElapsed / duratoinInSeconds
            updateDurationLabelWithTime(time: duratoinInSeconds)
        }
        self.slider?.value = Float(ratio)
        updateCurrentTimeLabelWithTime(time: secondsElapsed)
        updateRemainingTimeLabelWithTime(time: duratoinInSeconds - secondsElapsed)
        
        //TODO: playerScrubbingDidUpdateTime delegate// may be not needed
    }
    
    fileprivate func updatePlayer(playIfNeeded: Bool) {
        let duratoinInSeconds = CMTimeGetSeconds((self.player.currentItem?.duration)!)
        let seconds = Float64(duratoinInSeconds) * Float64((self.slider?.value)!)
        let time = CMTimeMakeWithSeconds(seconds, Int32(NSEC_PER_SEC))
        self.player.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (done: Bool) -> Void in
            if playIfNeeded && Float((self.slider?.value)!) < Float((self.slider?.maximumValue)!) {
                if self.playAfterDrag {
                    self.player.play()
                }
            }
        })
    }
    
    @objc fileprivate func sliderTapAction(gesture: UITapGestureRecognizer) {
        
    }
    
    @objc fileprivate func sliderValueChangeAction(slider: UISlider, event: UIEvent) {
        let touch =  event.allTouches?.first
        if touch?.phase == .began {
            playAfterDrag = self.player.rate > 0
            self.player.pause()
        }
        updatePlayer(playIfNeeded: touch?.phase == .ended)
    }
}

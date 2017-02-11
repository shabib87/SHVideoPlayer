//
//  SHVideoPlayerScrubber.swift
//  Pods
//
//  Created by Shabib Hossain on 11/16/16.
//
//

import UIKit
import AVFoundation

public class SHVideoPlayerScrubber: NSObject {
    
    fileprivate var player: AVPlayer
    fileprivate var slider: UISlider
    
    fileprivate var currentTimeLabel: UILabel
    fileprivate var durationLabel: UILabel
    fileprivate var remainingTimeLabel: UILabel
    fileprivate var playPauseButton: UIButton
    
    fileprivate var timeObserver: Any?
    
    fileprivate var playAfterDrag: Bool = true
    fileprivate var framesPerSecond: Float = 0.0
    
    public init(with player:AVPlayer, slider: UISlider, currentTimeLabel: UILabel, durationLabel: UILabel, remainingTimeLabel: UILabel, playPauseButton: UIButton) {
        self.player = player
        self.slider = slider
        self.currentTimeLabel = currentTimeLabel
        self.durationLabel = durationLabel
        self.remainingTimeLabel = remainingTimeLabel
        self.playPauseButton = playPauseButton
    }
    
    public func initComponents() {
        self.setUpPlayer()
        self.setSliderTapAction()
        self.setSliderValueChangeAction()
        self.setPlayPauseButtonAction()
    }
    
    fileprivate func setUpPlayer() {
        self.player.pause()
        removeTimeObserver()
        self.framesPerSecond = nominalFrameRateForPlayer()
        setupTimeObserver()
        updateCurrentTimeLabelWithTime(time: 0)
        var duration = self.player.currentItem?.duration
        if !CMTIME_IS_VALID(duration!) || CMTIME_IS_INDEFINITE(duration!) {
            self.player.currentItem?.addObserver(self, forKeyPath: SHVideoPlayerConstants.ObserverKey.duration, options: .new, context: nil)
        }
    }
    
    fileprivate func setSliderTapAction() {
        if self.slider == nil { return }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sliderTapAction))
        slider.addGestureRecognizer(gesture)
    }
    
    fileprivate func setSliderValueChangeAction() {
        slider.addTarget(self, action: #selector(sliderValueChangeAction), for: .valueChanged)
    }
    
    fileprivate func setPlayPauseButtonAction() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
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
        self.currentTimeLabel.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func updateDurationLabelWithTime(time: TimeInterval) {
        if self.durationLabel == nil { return }
        self.durationLabel.text = "/\(timecodeForTimeInterval(time: time))"
    }
    
    fileprivate func updateRemainingTimeLabelWithTime(time: TimeInterval) {
        if self.remainingTimeLabel == nil { return }
        self.remainingTimeLabel.text = timecodeForTimeInterval(time: time)
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
        self.slider.value = Float(ratio)
        updateCurrentTimeLabelWithTime(time: secondsElapsed)
        updateRemainingTimeLabelWithTime(time: duratoinInSeconds - secondsElapsed)
    }
    
    fileprivate func updatePlayer(playIfNeeded: Bool) {
        let duratoinInSeconds = CMTimeGetSeconds((self.player.currentItem?.duration)!)
        let seconds = Float64(duratoinInSeconds) * Float64((self.slider.value))
        let time = CMTimeMakeWithSeconds(seconds, Int32(NSEC_PER_SEC))
        self.player.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (done: Bool) -> Void in
            if playIfNeeded && Float(self.slider.value) < Float(self.slider.maximumValue) {
                if self.playAfterDrag {
                    self.player.play()
                }
            }
        })
    }
    
    //MARK: actions 
    
    @objc fileprivate func sliderTapAction(gesture: UITapGestureRecognizer) {
        if self.slider.isHighlighted { return }
        var isPlaying = self.player.rate > 0
        var trackRect = self.slider.trackRect(forBounds: self.slider.bounds)
        var thumbRect = self.slider.thumbRect(forBounds: self.slider.bounds, trackRect: trackRect, value: 0)
        var thumbWidth = thumbRect.size.width
        var point = gesture.location(in: self.slider)
        var ratio: Float = 0.0
        if point.x > thumbWidth / 2 {
            ratio = 0.0
        } else if point.x > (self.slider.bounds.size.width - thumbWidth / 2) {
            ratio  = 1.0
        } else {
            ratio = Float((point.x - thumbWidth / 2) / (self.slider.bounds.size.width - thumbWidth))
        }
        var del = ratio * (self.slider.maximumValue - self.slider.minimumValue)
        var value = self.slider.maximumValue + del;
        self.slider.setValue(value, animated: true)
        updatePlayer(playIfNeeded: isPlaying)
    }
    
    @objc fileprivate func sliderValueChangeAction(slider: UISlider, event: UIEvent) {
        let touch =  event.allTouches?.first
        if touch?.phase == .began {
            playAfterDrag = self.player.rate > 0
            self.player.pause()
        }
        updatePlayer(playIfNeeded: touch?.phase == .ended)
    }
    
    @objc fileprivate func playPauseButtonAction(button: UIButton) {
        if self.player.rate == 0 {
            // possible to not work
            // CMTIME_COMPARE_INLINE not supported in swift
            if self.player.currentTime() == self.player.currentItem?.duration {
                // if the video has ended, seeking to initial time and playing it again
                // in one word, replay!
                self.player.seek(to: kCMTimeZero, completionHandler: { (done: Bool) in
                    self.player.play()
                })
            } else {
                self.player.play()
            }
        } else {
            self.player.pause()
        }
    }
    
    //MARK: observer kvo
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if CMTIME_IS_VALID((self.player.currentItem?.duration)!) && !CMTIME_IS_INDEFINITE((self.player.currentItem?.duration)!) {
            self.player.currentItem?.removeObserver(self, forKeyPath: SHVideoPlayerConstants.ObserverKey.duration)
            playerTimeChanged()
        }
    }
}

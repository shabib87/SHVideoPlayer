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
    
    fileprivate let player: AVPlayer
    fileprivate var slider: UISlider
    
    fileprivate var currentTimeLabel: UILabel
    fileprivate var durationLabel: UILabel
    fileprivate var remainingTimeLabel: UILabel
    fileprivate var playButton: UIButton
    
    fileprivate var timeObserver: Any?
    
    fileprivate var playAfterDrag: Bool = true
    fileprivate var framesPerSecond: Float = 0.0
    
    public weak var delegate: SHVideoPlayerScrubberDelegate?
    
    public init(with player:AVPlayer, slider: UISlider, currentTimeLabel: UILabel, durationLabel: UILabel, remainingTimeLabel: UILabel, playButton: UIButton) {
        self.player = player
        self.slider = slider
        self.currentTimeLabel = currentTimeLabel
        self.durationLabel = durationLabel
        self.remainingTimeLabel = remainingTimeLabel
        self.playButton = playButton
    }
    
    public func initComponents() {
        self.setUpPlayer()
        self.setSliderTapAction()
        self.setSliderValueChangeAction()
        self.setPlayPauseButtonAction()
    }
    
    fileprivate func setUpPlayer() {
        self.pause()
        removeTimeObserver()
        self.framesPerSecond = nominalFrameRateForPlayer()
        setupTimeObserver()
        updateCurrentTimeLabelWithTime(time: 0)
        self.addPlayerItemPlayDurationObserver()
        self.addPlayerDidEndPlayingVideoObserver()
    }
    
    fileprivate func addPlayerItemPlayDurationObserver() {
        guard let duration = self.player.currentItem?.duration else {
            print("duration is nil")
            return
        }
        if !CMTIME_IS_VALID(duration) || CMTIME_IS_INDEFINITE(duration) {
            self.player.currentItem?.addObserver(self, forKeyPath: SHVideoPlayerConstants.ObserverKey.duration, options: .new, context: nil)
        }
    }
    
    fileprivate func setSliderTapAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sliderTapAction))
        slider.addGestureRecognizer(gesture)
    }
    
    fileprivate func setSliderValueChangeAction() {
        slider.addTarget(self, action: #selector(sliderValueChangeAction), for: .valueChanged)
    }
    
    fileprivate func setPlayPauseButtonAction() {
        playButton.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
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
            self.player.removeTimeObserver(timeObserver ?? self)
        }
        timeObserver = nil
    }
    
    fileprivate func nominalFrameRateForPlayer() -> Float {
        var track: AVAssetTrack? = nil
        if let tracks = self.player.currentItem?.asset.tracks(withMediaType: AVMediaTypeVideo) {
            if tracks.count != 0 {
                track = tracks[0]
            }
        }
        if let nominalFrameRate = track?.nominalFrameRate {
            return nominalFrameRate
        }
        return 0.0
    }
    
    fileprivate func updateCurrentTimeLabelWithTime(time: TimeInterval) {
        self.currentTimeLabel.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func updateDurationLabelWithTime(time: TimeInterval) {
        self.durationLabel.text = "/\(timecodeForTimeInterval(time: time))"
    }
    
    fileprivate func updateRemainingTimeLabelWithTime(time: TimeInterval) {
        self.remainingTimeLabel.text = timecodeForTimeInterval(time: time)
    }
    
    fileprivate func timecodeForTimeInterval(time: TimeInterval) -> String {
        let sign = time < 0 ? "-" : ""
        var timeCode = ""
        let absTime = Int(abs(time))
        let hours = absTime / 60 / 24
        let minutes = (absTime - hours * 24) / 60
        let seconds = (absTime - hours * 24) - minutes * 60
        if hours > 0 {
            timeCode = String(format: "\(sign)%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            timeCode = String(format: "\(sign)%02d:%02d", minutes, seconds)
        }
        return timeCode
    }
    
    fileprivate func playerTimeChanged() {
        guard let currentItem = self.player.currentItem else {
            print("players current item is nil")
            return
        }
        self.updateTimeLabels(currentItem: currentItem)
    }
    
    private func updateTimeLabels(currentItem: AVPlayerItem) {
        let secondsElapsed = CMTimeGetSeconds(currentItem.currentTime())
        var duratoinInSeconds = 0.0
        var ratio = 0.0
        if CMTIME_IS_VALID(currentItem.duration) && !CMTIME_IS_INDEFINITE(currentItem.duration) {
            duratoinInSeconds = CMTimeGetSeconds(currentItem.duration)
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
        guard let currentItem = self.player.currentItem else {
            print("players current item is nil")
            return
        }
        self.updatePlayerWith(currentItem: currentItem,  playIfNeeded: playIfNeeded)
    }
    
    private func updatePlayerWith(currentItem: AVPlayerItem, playIfNeeded: Bool) {
        let duratoinInSeconds = CMTimeGetSeconds(currentItem.duration)
        let seconds = Float64(duratoinInSeconds) * Float64((self.slider.value))
        let time = CMTimeMakeWithSeconds(seconds, Int32(NSEC_PER_SEC))
        self.player.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero, completionHandler: { (done: Bool) -> Void in
            if playIfNeeded && Float(self.slider.value) < Float(self.slider.maximumValue) {
                if self.playAfterDrag {
                    self.play()
                }
            }
        })
    }
    
    //MARK: actions 
    
    @objc fileprivate func sliderTapAction(gesture: UITapGestureRecognizer) {
        if self.slider.isHighlighted { return }
        let isPlaying = self.player.rate > 0
        let trackRect = self.slider.trackRect(forBounds: self.slider.bounds)
        let thumbRect = self.slider.thumbRect(forBounds: self.slider.bounds, trackRect: trackRect, value: 0)
        let thumbWidth = thumbRect.size.width
        let point = gesture.location(in: self.slider)
        let value = self.seekValueFromSliderTap(point: point, thumbWidth: thumbWidth)
        self.slider.setValue(value, animated: true)
        updatePlayer(playIfNeeded: isPlaying)
    }
    
    private func seekValueFromSliderTap(point: CGPoint, thumbWidth: CGFloat) -> Float {
        var ratio: Float = 0.0
        if point.x < thumbWidth / 2 {
            ratio = 0.0
        } else if point.x > (self.slider.bounds.size.width - thumbWidth / 2) {
            ratio  = 1.0
        } else {
            ratio = Float((point.x - thumbWidth / 2) / (self.slider.bounds.size.width - thumbWidth))
        }
        let del = ratio * (self.slider.maximumValue - self.slider.minimumValue)
        return self.slider.minimumValue + del
    }
    
    @objc fileprivate func sliderValueChangeAction(slider: UISlider, event: UIEvent) {
        let touch =  event.allTouches?.first
        if touch?.phase == .began {
            playAfterDrag = self.player.rate > 0
            self.pause()
        }
        updatePlayer(playIfNeeded: touch?.phase == .ended)
    }
    
    @objc fileprivate func playPauseButtonAction(button: UIButton) {
        if self.player.rate == 0 {
            self.resumeOrPlayAction()
        } else {
            self.pause()
        }
    }
    
    private func resumeOrPlayAction() {
        if self.player.currentTime() == self.player.currentItem?.duration {
            // replaying video
            self.player.seek(to: kCMTimeZero, completionHandler: { (done: Bool) in
                self.play()
            })
        } else {
            self.play()
        }
    }
    
    public func play() {
        self.player.play()
        if delegate != nil {
            delegate?.playerStateDidChange(isPlaying: true)
        }
    }
    
    public func pause() {
        self.player.pause()
        if delegate != nil {
            delegate?.playerStateDidChange(isPlaying: false)
        }
    }
    
    fileprivate func addDidEndVideoObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }
    
    fileprivate func removeDidEndVideoObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }
    
    fileprivate func addPlayerDidEndPlayingVideoObserver() {
        self.removeDidEndVideoObserver()
        self.addDidEndVideoObserver()
    }
    
    @objc fileprivate func playerDidFinishPlaying(notification: NSNotification) {
        self.removeDidEndVideoObserver()
        if delegate != nil {
            delegate?.playerStateDidChange(isPlaying: false)
        }
    }
    
    public func startPreparingForDeinit() {
        self.player.pause()
        removeCurrentItemObserver()
    }
    
    deinit {
        removeCurrentItemObserver()
        removeDidEndVideoObserver()
    }
    
    private func removeCurrentItemObserver() {
        self.player.currentItem?.removeObserver(self, forKeyPath: SHVideoPlayerConstants.ObserverKey.duration)
    }
    
    //MARK: observer kvo
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == SHVideoPlayerConstants.ObserverKey.duration {
            guard let currentItem = self.player.currentItem else {
                print("players current item is nil")
                return
            }
            if CMTIME_IS_VALID(currentItem.duration) && !CMTIME_IS_INDEFINITE(currentItem.duration) {
                removeCurrentItemObserver()
                playerTimeChanged()
            }
        }
    }
}

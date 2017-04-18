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

public class SHVideoPlayer: UIView {
    
    public var backActionCompletionHandler:(() -> Void)?
    
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var playerControl: SHVideoPlayerControl!
    fileprivate var playerLayer: SHVideoPlayerLayer!
    fileprivate var playerScrubber: SHVideoPlayerScrubber!
    fileprivate var orientationHandler: SHVideoPlayerOrientationHandler!
    
    fileprivate var customPlayerControl: SHVideoPlayerControl?
    fileprivate var videoItemURL: URL!
    fileprivate var playerControlsAreVisible = true
    fileprivate var hasURLSet = false
    
    fileprivate let FadeOutAnimationTimeInterval: Double = 0.5
    fileprivate let AutoFadeOutTimeInterval: Double = 5.0
    
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
    
    public func playWithURL(_ url: URL, title: String = "") {
        playerControl.titleLabel?.text = title
        videoItemURL = url
        playerLayer.videoURL = videoItemURL
        hasURLSet = true
        self.preparePlayerScrubber()
        self.playerScrubber.initComponents()
        self.play()
    }
    
    fileprivate func play() {
        if !hasURLSet {
            playerLayer?.videoURL = videoItemURL
            hasURLSet = true
        }
        self.playerScrubber?.play()
    }
    
    fileprivate func initUI() {
        self.preparePlayerControl()
        self.preparePlayer()
    }
    
    fileprivate func preparePlayerControl() {
        if let customView = customPlayerControl {
            playerControl = customView
        } else {
            playerControl =  SHVideoPlayerDefaultControl()
        }
        self.addSubview(playerControl.controlView)
        self.orientationHandler = SHVideoPlayerOrientationHandler(playerControlView: playerControl)
        playerControl.controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        playerControl.backButton?.addTarget(self, action: #selector(self.backButtonAction(_:)), for: .touchUpInside)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func preparePlayer() {
        playerLayer = SHVideoPlayerLayer()
        playerLayer.backgroundColor = .black
        guard let _playerLayer = playerLayer else {
            return
        }
        insertSubview(_playerLayer, at: 0)
        _playerLayer.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.addPlayerObservers()
        self.layoutIfNeeded()
    }
    
    fileprivate func addPlayerObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) { notification in
            self.playerScrubber?.pause()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { notification in
            self.playerScrubber?.play()
        }
    }
    
    fileprivate func preparePlayerScrubber() {
        self.playerScrubber = nil
        self.createPlayerScrubber()
        self.playerScrubber.delegate = self
    }
    
    private func createPlayerScrubber() {
        guard let player = playerLayer.player,
            let timeSlider = playerControl.timeSlider,
            let durationLabel = playerControl.durationLabel,
            let remainingTimeLabel = playerControl.remainingTimeLabel,
            let currentTimeLabel = playerControl.currentTimeLabel,
            let playButton = playerControl.playButton else {
                return
        }
        self.playerScrubber = SHVideoPlayerScrubber(with: player, slider: timeSlider, currentTimeLabel: currentTimeLabel, durationLabel: durationLabel, remainingTimeLabel: remainingTimeLabel, playButton: playButton)
    }
    
    fileprivate func autoFadeOutControlBar() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideControlViewAnimated), object: nil)
        self.perform(#selector(hideControlViewAnimated), with: nil, afterDelay: AutoFadeOutTimeInterval)
    }
    
    @objc fileprivate func backButtonAction(_ button: UIButton) {
        playerScrubber.startPreparingForDeinit()
        playerLayer?.startPreparingForDeinit()
        backActionCompletionHandler?()
    }
    
    @objc fileprivate func tapGestureTapped(_ sender: UIGestureRecognizer) {
        if self.playerControlsAreVisible {
            playerControl.hidePlayerUIComponents()
        } else {
            playerControl.showPlayerUIComponents()
        }
        self.playerControlsAreVisible = !self.playerControlsAreVisible;
    }
    
    @objc fileprivate func hideControlViewAnimated() {
        UIView.animate(withDuration: FadeOutAnimationTimeInterval, animations: {
            self.playerControl.hidePlayerUIComponents()
            if self.orientationHandler.isLandscape {
                UIApplication.shared.isStatusBarHidden = true
            }
        }, completion: nil)
    }
    
    @objc fileprivate func showControlViewAnimated() {
        UIView.animate(withDuration: FadeOutAnimationTimeInterval, animations: {
            self.playerControl.showPlayerUIComponents()
            UIApplication.shared.isStatusBarHidden = false
        }, completion: { (_) in
            self.autoFadeOutControlBar()
        })
    }
}

extension SHVideoPlayer: SHVideoPlayerScrubberDelegate {
    
    public func playerStateDidChange(isPlaying: Bool) {
        if isPlaying {
            autoFadeOutControlBar()
            playerControl.playButton?.isSelected = true
        } else {
            playerControl.playButton?.isSelected = false
        }
    }
}

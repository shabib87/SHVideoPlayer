//
//  SHVideoPlayer.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import Foundation
import AVFoundation

public class SHVideoPlayer: UIView {
    
    public var backActionCompletionHandler:(() -> Void)?
    
    private var tapGesture: UITapGestureRecognizer!
    private var playerLayer: SHVideoPlayerLayer!
    private var playerManager: SHVideoPlayerManager!
    private var orientationHandler: SHVideoPlayerOrientationHandler!
    
    private var customPlayerControl: SHVideoPlayerControl?
    private var videoItemURL: URL!
    private var playerControlsAreVisible = true
    
    private let FadeOutAnimationTimeInterval: Double = 0.5
    private let AutoFadeOutTimeInterval: Double = 5.0
    
    fileprivate var playerControl: SHVideoPlayerControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initUI()
    }
    
    public convenience init (playerControl: SHVideoPlayerControl?) {
        self.init(frame:CGRect.zero)
        self.customPlayerControl = playerControl
        self.initUI()
    }
    
    public convenience init() {
        self.init(playerControl:nil)
    }
    
    public func playWithURL(_ url: URL, title: String = "") {
        playerControl.titleLabel?.text = title
        videoItemURL = url
        playerLayer.configPlayer()
        //TODO: changing video causes crash now, fix it
        self.preparePlayerManager()
        self.playerManager.initComponents()
    }
    
    fileprivate func play() {
        self.playerManager?.play()
    }
    
    private func initUI() {
        self.preparePlayerControl()
        self.preparePlayer()
    }
    
    private func preparePlayerControl() {
        playerControl = self.playerControlView()
        self.addSubview(playerControl.controlView)
        self.orientationHandler = SHVideoPlayerOrientationHandler(playerControlView: playerControl)
        self.setupPlayerControlView()
        self.playerControl.backButton?.addTarget(self, action: #selector(self.backButtonAction(_:)), for: .touchUpInside)
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureTapped(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func playerControlView() -> SHVideoPlayerControl {
        if let customView = customPlayerControl {
            return customView
        } else {
            return  SHVideoPlayerDefaultControl()
        }
    }
    
    private func setupPlayerControlView() {
        playerControl.controlView.translatesAutoresizingMaskIntoConstraints = false
        playerControl.controlView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        playerControl.controlView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        playerControl.controlView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        playerControl.controlView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func preparePlayer() {
        playerLayer = SHVideoPlayerLayer()
        playerLayer.backgroundColor = .black
        self.setupPlayerLayer()
        self.addPlayerObservers()
        self.layoutIfNeeded()
    }
    
    private func setupPlayerLayer() {
        guard let _playerLayer = playerLayer else { print("SHVideoPlayer: setupPlayerLayer():- player layer is nil"); return }
        insertSubview(_playerLayer, at: 0)
        _playerLayer.translatesAutoresizingMaskIntoConstraints = false
        _playerLayer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _playerLayer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        _playerLayer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _playerLayer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func addPlayerObservers() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) { notification in self.playerManager?.pause() }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { notification in self.playerManager?.play() }
    }
    
    private func preparePlayerManager() {
        self.playerManager = nil
        self.createPlayerManager()
        self.playerManager.delegate = self
    }
    
    private func createPlayerManager() {
        guard let player = playerLayer.player,
            let timeSlider = playerControl.timeSlider,
            let durationLabel = playerControl.durationLabel,
            let remainingTimeLabel = playerControl.remainingTimeLabel,
            let currentTimeLabel = playerControl.currentTimeLabel,
            let playButton = playerControl.playButton,
            let activityIndicatorView = playerControl.activityIndicatorView,
            let itemURL = videoItemURL else {
                print("SHVideoPlayer: createPlayerManager():- One or some of the manager items are nil")
                return
        }
        self.playerManager = SHVideoPlayerManager(with: player, slider: timeSlider, currentTimeLabel: currentTimeLabel, durationLabel: durationLabel, remainingTimeLabel: remainingTimeLabel, playButton: playButton, activityIndicatorView: activityIndicatorView)
        self.playerManager.videoItemURL = itemURL
    }
    
    fileprivate func autoFadeOutControlBar() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hideControlViewAnimated), object: nil)
        self.perform(#selector(hideControlViewAnimated), with: nil, afterDelay: AutoFadeOutTimeInterval)
    }
    
    @objc private func backButtonAction(_ button: UIButton) {
        playerManager.startPreparingForDeinit()
        playerLayer?.startPreparingForDeinit()
        backActionCompletionHandler?()
    }
    
    @objc private func tapGestureTapped(_ sender: UIGestureRecognizer) {
        if self.playerControlsAreVisible {
            playerControl.hidePlayerUIComponents()
        } else {
            playerControl.showPlayerUIComponents()
        }
        self.playerControlsAreVisible = !self.playerControlsAreVisible
    }
    
    @objc private func hideControlViewAnimated() {
        UIView.animate(withDuration: FadeOutAnimationTimeInterval, animations: {
            self.playerControl.hidePlayerUIComponents()
            if self.orientationHandler.isLandscape {
                UIApplication.shared.isStatusBarHidden = true
            }
        }, completion: nil)
    }
    
    @objc private func showControlViewAnimated() {
        UIView.animate(withDuration: FadeOutAnimationTimeInterval, animations: {
            self.playerControl.showPlayerUIComponents()
            UIApplication.shared.isStatusBarHidden = false
        }, completion: { (_) in
            self.autoFadeOutControlBar()
        })
    }
}

extension SHVideoPlayer: SHVideoPlayerManagerDelegate {
    
    func playerIsReadyToPlay() {
        self.play()
    }
    
    func playerStateDidChange(isPlaying: Bool) {
        if isPlaying {
            autoFadeOutControlBar()
            playerControl.playButton?.isSelected = true
        } else {
            playerControl.playButton?.isSelected = false
        }
    }
}

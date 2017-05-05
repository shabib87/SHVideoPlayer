//
//  SHVideoPlayerDefaultControl.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit

public class SHVideoPlayerDefaultControl: UIView {
    
    var _titleLabel = UILabel()
    var _currentTimeLabel = UILabel()
    var _durationLabel = UILabel()
    var _remainingTimeLabel = UILabel()
    
    var _playButton = UIButton(type: .custom)
    var _backButton = UIButton(type: .custom)
    var _fullScreenButton = UIButton(type: .custom)
    
    var _timeSlider = UISlider()
    var _progressView = UIProgressView()
    
    var bgContainerView = UIView()
    var topContainerView = UIView()
    var bottomContainerView = UIView()
    
    var isFullScreen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUIComponents()
        addConstraintsToComponents()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUIComponents()
        addConstraintsToComponents()
    }
    
    private func configureBGContainerView() {
        bgContainerView.addSubview(topContainerView)
        bgContainerView.addSubview(bottomContainerView)
        bgContainerView.addSubview(_playButton)
    }
    
    private func configureTopContainerView() {
        topContainerView.addSubview(_backButton)
        topContainerView.addSubview(_titleLabel)
        topContainerView.addSubview(_fullScreenButton)
    }
    
    private func configureBottomContainerView() {
        bottomContainerView.addSubview(_currentTimeLabel)
        bottomContainerView.addSubview(_remainingTimeLabel)
        bottomContainerView.addSubview(_durationLabel)
        bottomContainerView.addSubview(_progressView)
        bottomContainerView.addSubview(_timeSlider)
    }
    
    private func configureBGColors() {
        bgContainerView.backgroundColor = UIColor.blackShadeColor()
        topContainerView.backgroundColor = UIColor.grayShadeColor()
        bottomContainerView.backgroundColor = UIColor.grayShadeColor()
    }
    
    private func configureDelegation() {
        configureBackButtonImage()
        configurePlayButtonNormalStateImage()
        configurePlayButtonSelectedStateImage()
        configureFullScreenButtonNormalStateImage()
    }
    
    private func configurePlayButtonNormalStateImage() {
        _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("play"), for: UIControlState())
    }
    
    private func configureBackButtonImage() {
        _backButton.setImage(SHVideoPlayerUtils.resourceImagePath("back"), for: .normal)
    }
    
    private func configurePlayButtonSelectedStateImage() {
        _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("pause"), for: .selected)
    }
    
    private func configureFullScreenButtonNormalStateImage() {
        _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("fullscreen"), for: .normal)
    }
    
    private func configureLabels() {
        configureTitleLabel()
        configureCurrentTimeLabel()
        configureRemainingTimeLabel()
        configureDurationLabel()
    }
    
    private func configureTitleLabel() {
        _titleLabel.textColor = .white
        _titleLabel.text = "Loading..."
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func configureCurrentTimeLabel() {
        _currentTimeLabel.textColor = .white
        _currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _currentTimeLabel.text = "00:00"
        _currentTimeLabel.textAlignment = .center
    }
    
    private func configureRemainingTimeLabel() {
        _remainingTimeLabel.textColor = .white
        _remainingTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _remainingTimeLabel.text = "00:00"
        _remainingTimeLabel.textAlignment = .right
    }
    
    private func configureDurationLabel() {
        _durationLabel.textColor = .white
        _durationLabel.font = UIFont.systemFont(ofSize: 12)
        _durationLabel.text = "/00:00"
        _durationLabel.textAlignment = .left
    }
    
    private func configureTimeSliders() {
        _timeSlider.maximumValue = 1.0
        _timeSlider.minimumValue = 0.0
        _timeSlider.value = 0.0
        _timeSlider.maximumTrackTintColor = .clear
        _timeSlider.minimumTrackTintColor = .white
    }
    
    private func configureProgressView() {
        _progressView.tintColor = UIColor.progressBarTintColor()
        _progressView.trackTintColor = UIColor.progressTrackTintColor()
    }
    
    private func initUIComponents() {
        self.addSubview(bgContainerView)
        configureBGUIContents()
        configureTopUIContents()
        configureDelegation()
    }
    
    private func configureBGUIContents() {
        configureBGContainerView()
        configureTopContainerView()
        configureBottomContainerView()
        configureBGColors()
    }
    
    private func configureTopUIContents() {
        configureLabels()
        configureTimeSliders()
        configureProgressView()
    }
    
    private func addConstraintsToComponents() {
        setBGContainers()
        setTopLayerContents()
        setPlayButtonConstraints()
        setBottomLayerContents()
    }
    
    private func setBGContainers() {
        setBGContainerViewConstraints()
        setTopContainerViewConstraints()
        setBottomContainerViewConstraints()
    }
    
    private func setTopLayerContents() {
        setBackButtonConstraints()
        setTitleLabelConstraints()
        setFullScreenButtonConstraints()
    }
    
    private func setBottomLayerContents() {
        setCurrentLabelConstraints()
        setTimeSliderConstraints()
        setProgressViewConstraints()
        setRemainingLabelConstraints()
        setDurationLabelContraints()
    }
    
    private func setBGContainerViewConstraints() {
        bgContainerView.translatesAutoresizingMaskIntoConstraints = false
        bgContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bgContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bgContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setTopContainerViewConstraints() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.leadingAnchor.constraint(equalTo: bgContainerView.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: bgContainerView.trailingAnchor).isActive = true
        topContainerView.topAnchor.constraint(equalTo: bgContainerView.topAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
    }
    
    private func setBottomContainerViewConstraints() {
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.leadingAnchor.constraint(equalTo: bgContainerView.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: bgContainerView.trailingAnchor).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: bgContainerView.bottomAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    private func setBackButtonConstraints() {
        _backButton.translatesAutoresizingMaskIntoConstraints = false
        _backButton.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor).isActive = true
        _backButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        _backButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        _backButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    private func setTitleLabelConstraints() {
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false
        _titleLabel.leadingAnchor.constraint(equalTo: _backButton.trailingAnchor).isActive = true
        _titleLabel.centerYAnchor.constraint(equalTo: _backButton.centerYAnchor).isActive = true
    }
    
    private func setFullScreenButtonConstraints() {
        _fullScreenButton.translatesAutoresizingMaskIntoConstraints = false
        _fullScreenButton.leadingAnchor.constraint(equalTo: _titleLabel.trailingAnchor, constant: 10.0).isActive = true
        _fullScreenButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -10.0).isActive = true
        _fullScreenButton.centerYAnchor.constraint(equalTo: _titleLabel.centerYAnchor).isActive = true
        _fullScreenButton.heightAnchor.constraint(equalToConstant: 37.0).isActive = true
        _fullScreenButton.widthAnchor.constraint(equalToConstant: 42.0).isActive = true
    }
    
    private func setPlayButtonConstraints() {
        _playButton.translatesAutoresizingMaskIntoConstraints = false
        _playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        _playButton.heightAnchor.constraint(equalToConstant: 42.0).isActive = true
        _playButton.widthAnchor.constraint(equalToConstant: 42.0).isActive = true
    }
    
    private func setCurrentLabelConstraints() {
        _currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        _currentTimeLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 10.0).isActive = true
        _currentTimeLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        _currentTimeLabel.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setTimeSliderConstraints() {
        _timeSlider.translatesAutoresizingMaskIntoConstraints = false
        _timeSlider.centerYAnchor.constraint(equalTo: _currentTimeLabel.centerYAnchor).isActive = true
        let leading = _timeSlider.leadingAnchor.constraint(equalTo: _currentTimeLabel.trailingAnchor, constant: 10.0)
        leading.isActive = true
        leading.priority = 750
        _timeSlider.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func setProgressViewConstraints() {
        _progressView.translatesAutoresizingMaskIntoConstraints = false
        _progressView.centerYAnchor.constraint(equalTo: _timeSlider.centerYAnchor).isActive = true
        _progressView.leadingAnchor.constraint(equalTo: _timeSlider.leadingAnchor).isActive = true
        _progressView.trailingAnchor.constraint(equalTo: _timeSlider.trailingAnchor).isActive = true
        _progressView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
    }
    
    private func setRemainingLabelConstraints() {
        _remainingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        _remainingTimeLabel.centerYAnchor.constraint(equalTo: _currentTimeLabel.centerYAnchor).isActive = true
        _remainingTimeLabel.leadingAnchor.constraint(equalTo: _timeSlider.trailingAnchor, constant: 10.0).isActive = true
        _remainingTimeLabel.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func setDurationLabelContraints() {
        _durationLabel.translatesAutoresizingMaskIntoConstraints = false
        _durationLabel.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        _durationLabel.centerYAnchor.constraint(equalTo: _currentTimeLabel.centerYAnchor).isActive = true
        _durationLabel.leadingAnchor.constraint(equalTo: _remainingTimeLabel.trailingAnchor).isActive = true
        _durationLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -10.0).isActive = true
    }
}

extension SHVideoPlayerDefaultControl: SHVideoPlayerControl {
    
    public var titleLabel: UILabel?  { get { return  _titleLabel } }
    public var currentTimeLabel: UILabel?  { get { return  _currentTimeLabel } }
    public var durationLabel: UILabel?  { get { return  _durationLabel } }
    public var remainingTimeLabel: UILabel? { get { return _remainingTimeLabel} }
    
    public var playButton: UIButton? { get { return  _playButton } }
    public var backButton: UIButton? { get { return  _backButton } }
    public var fullScreenButton: UIButton? { get { return  _fullScreenButton } }
    
    public var timeSlider: UISlider? { get { return  _timeSlider } }
    public var progressView: UIProgressView? { get { return  _progressView } }
    
    public var controlView: UIView { return self }
    
    public func updateUI(_ isForFullScreen: Bool) {
        isFullScreen = isForFullScreen
        if isFullScreen {
            updateFullScreenImage()
        } else {
            updateSmallScreenImage()
        }
    }
    
    private func updateFullScreenImage() {
        _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("fullscreen"), for: UIControlState())
    }
    
    private func updateSmallScreenImage() {
        _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("smallscreen"), for: UIControlState())
    }
    
    public func showPlayerUIComponents() {
        _playButton.isHidden = false
        topContainerView.alpha    = 1.0
        bottomContainerView.alpha = 1.0
        bgContainerView.backgroundColor = UIColor.blackShadeColor()
    }
    
    public func hidePlayerUIComponents() {
        _playButton.isHidden = true
        topContainerView.alpha = 0.0
        bottomContainerView.alpha = 0.0
        bgContainerView.backgroundColor = .clear
    }
}

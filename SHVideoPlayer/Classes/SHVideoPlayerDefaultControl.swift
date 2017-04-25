//
//  SHVideoPlayerDefaultControl.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit
import SnapKit

public class SHVideoPlayerDefaultControl: UIView {
    
    weak public var delegate: SHVideoPlayerDefaultControlCustomizationDelegate?
    
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
        bgContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        topContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        bottomContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }
    
    private func configureDelegation() {
        configureBackButtonImage()
        configurePlayButtonNormalStateImage()
        configurePlayButtonSelectedStateImage()
        configureFullScreenButtonNormalStateImage()
    }
    
    private func configurePlayButtonNormalStateImage() {
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonNormalStateImage(), for: UIControlState())
        } else {
            _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("play"), for: UIControlState())
        }
    }
    
    private func configureBackButtonImage() {
        if delegate != nil {
            _backButton.setImage(delegate?.backButtonImage(), for: .normal)
        } else {
            _backButton.setImage(SHVideoPlayerUtils.resourceImagePath("back"), for: .normal)
        }
    }
    
    private func configurePlayButtonSelectedStateImage() {
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonSelectedStateImage(), for: .selected)
        } else {
            _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("pause"), for: .selected)
        }
    }
    
    private func configureFullScreenButtonNormalStateImage() {
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: .normal)
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("fullscreen"), for: .normal)
        }
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
        _progressView.tintColor = SHVideoPlayerUtils.progressBarTintColor()
        _progressView.trackTintColor = SHVideoPlayerUtils.progressTrackTintColor()
    }
    
    private func initUIComponents() {
        self.addSubview(bgContainerView)
        configureBGContainerView()
        configureTopContainerView()
        configureBottomContainerView()
        configureBGColors()
        configureLabels()
        configureTimeSliders()
        configureDelegation()
    }
    
    private func addConstraintsToComponents() {
        setBGContainerViewConstraints()
        setTopContainerViewConstraints()
        setBottomContainerViewConstraints()
        setBackButtonConstraints()
        setTitleLabelConstraints()
        setFullScreenButtonConstraints()
        setPlayButtonConstraints()
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
        _currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomContainerView.snp.left).offset(10)
            make.centerY.equalTo(bottomContainerView)
            make.width.equalTo(40)
        }
    }
    
    private func setTimeSliderConstraints() {
        _timeSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_currentTimeLabel.snp.right).offset(10).priority(750)
            make.height.equalTo(30)
        }
    }
    
    private func setProgressViewConstraints() {
        _progressView.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(_timeSlider)
            make.height.equalTo(2)
        }
    }
    
    private func setRemainingLabelConstraints() {
        _remainingTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_timeSlider.snp.right).offset(10)
            make.width.equalTo(40)
        }
    }
    
    private func setDurationLabelContraints() {
        _durationLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_remainingTimeLabel.snp.right).offset(0)
            make.width.equalTo(40)
            make.right.equalTo(bottomContainerView.snp.right).offset(-10)
        }
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
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("fullscreen"), for: UIControlState())
        }
    }
    
    private func updateSmallScreenImage() {
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("smallscreen"), for: UIControlState())
        }
    }
    
    public func showPlayerUIComponents() {
        _playButton.isHidden = false
        topContainerView.alpha    = 1.0
        bottomContainerView.alpha = 1.0
        bgContainerView.backgroundColor = SHVideoPlayerUtils.blackShadeColor()
    }
    
    public func hidePlayerUIComponents() {
        _playButton.isHidden = true
        topContainerView.alpha = 0.0
        bottomContainerView.alpha = 0.0
        bgContainerView.backgroundColor = .clear
    }
}

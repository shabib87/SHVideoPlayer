//
//  SHVideoPlayerDefaultControl.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit
import SnapKit

public class SHVideoPlayerDefaultControl: UIView, SHVideoPlayerDefaultControlsCustomizationProtocol {
    
    weak public var delegate: SHVideoPlayerDefaultControlCustomizationDelegate?
    
    var _titleLabel = UILabel()
    var _currentTimeLabel = UILabel()
    var _durationLabel = UILabel()
    var _remainingTimeLabel = UILabel()
    
    var _playButton = UIButton(type: .custom)
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
    
    fileprivate func configureBGContainerView() {
        bgContainerView.addSubview(topContainerView)
        bgContainerView.addSubview(bottomContainerView)
        bgContainerView.addSubview(_playButton)
    }
    
    fileprivate func configureTopContainerView() {
        topContainerView.addSubview(_titleLabel)
        topContainerView.addSubview(_fullScreenButton)
    }
    
    fileprivate func configureBottomContainerView() {
        bottomContainerView.addSubview(_currentTimeLabel)
        bottomContainerView.addSubview(_remainingTimeLabel)
        bottomContainerView.addSubview(_durationLabel)
        bottomContainerView.addSubview(_progressView)
        bottomContainerView.addSubview(_timeSlider)
    }
    
    fileprivate func configureBGColors() {
        bgContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        topContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        bottomContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }
    
    fileprivate func configureDelegation() {
        configurePlayButtonNormalStateImage()
        configurePlayButtonSelectedStateImage()
        configureFullScreenButtonNormalStateImage()
    }
    
    fileprivate func configurePlayButtonNormalStateImage() {
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonNormalStateImage(), for: UIControlState())
        } else {
            _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("SHVideoPlayer_play"), for: UIControlState())
        }
    }
    
    fileprivate func configurePlayButtonSelectedStateImage() {
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonSelectedStateImage(), for: .selected)
        } else {
            _playButton.setImage(SHVideoPlayerUtils.resourceImagePath("SHVideoPlayer_pause"), for: .selected)
        }
    }
    
    fileprivate func configureFullScreenButtonNormalStateImage() {
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: .normal)
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("SHVideoPlayer_fullscreen"), for: .normal)
        }
    }
    
    fileprivate func configureLabels() {
        configureTitleLabel()
        configureCurrentTimeLabel()
        configureRemainingTimeLabel()
        configureDurationLabel()
    }
    
    fileprivate func configureTitleLabel() {
        _titleLabel.textColor = .white
        _titleLabel.text = "This is the title"
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    fileprivate func configureCurrentTimeLabel() {
        _currentTimeLabel.textColor = .white
        _currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _currentTimeLabel.text = "00:00"
        _currentTimeLabel.textAlignment = .center
    }
    
    fileprivate func configureRemainingTimeLabel() {
        _remainingTimeLabel.textColor = .white
        _remainingTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _remainingTimeLabel.text = "00:00"
        _remainingTimeLabel.textAlignment = .right
    }
    
    fileprivate func configureDurationLabel() {
        _durationLabel.textColor = .white
        _durationLabel.font = UIFont.systemFont(ofSize: 12)
        _durationLabel.text = "/00:00"
        _durationLabel.textAlignment = .left
    }
    
    fileprivate func configureTimeSliders() {
        _timeSlider.maximumValue = 1.0
        _timeSlider.minimumValue = 0.0
        _timeSlider.value = 0.0
        _timeSlider.maximumTrackTintColor = .clear
        _timeSlider.minimumTrackTintColor = .white
    }
    
    fileprivate func configureProgressView() {
        _progressView.tintColor = SHVideoPlayerUtils.progressBarTintColor()
        _progressView.trackTintColor = SHVideoPlayerUtils.progressTrackTintColor()
    }
    
    fileprivate func initUIComponents() {
        self.addSubview(bgContainerView)
        configureBGContainerView()
        configureTopContainerView()
        configureBottomContainerView()
        configureBGColors()
        configureLabels()
        configureTimeSliders()
        configureDelegation()
    }
    
    fileprivate func addConstraintsToComponents() {
        setBGContainerViewConstraints()
        setTopContainerViewConstraints()
        setBottomContainerViewConstraints()
        setTitleLabelConstraints()
        setFullScreenButtonConstraints()
        setPlayButtonConstraints()
        setCurrentLabelConstraints()
        setTimeSliderConstraints()
        setProgressViewConstraints()
        setRemainingLabelConstraints()
        setDurationLabelContraints()
    }
    
    fileprivate func setBGContainerViewConstraints() {
        bgContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    fileprivate func setTopContainerViewConstraints() {
        topContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bgContainerView)
            make.height.equalTo(65)
        }
    }
    
    fileprivate func setBottomContainerViewConstraints() {
        bottomContainerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bgContainerView)
            make.height.equalTo(50)
        }
    }
    
    fileprivate func setTitleLabelConstraints() {
        _titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topContainerView.snp.left).offset(10)
            make.centerY.equalTo(topContainerView)
        }
    }
    
    fileprivate func setFullScreenButtonConstraints() {
        _fullScreenButton.snp.makeConstraints { (make) in
            make.width.equalTo(37)
            make.height.equalTo(42)
            make.centerY.equalTo(_titleLabel)
            make.left.equalTo(_titleLabel.snp.right).offset(10)
            make.right.equalTo(topContainerView.snp.right).offset(-10)
        }
    }
    
    fileprivate func setPlayButtonConstraints() {
        _playButton.snp.makeConstraints { (make) in
            make.width.equalTo(42)
            make.height.equalTo(42)
            make.centerX.centerY.equalTo(self)
        }
    }
    
    fileprivate func setCurrentLabelConstraints() {
        _currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomContainerView.snp.left).offset(10)
            make.centerY.equalTo(bottomContainerView)
            make.width.equalTo(40)
        }
    }
    
    fileprivate func setTimeSliderConstraints() {
        _timeSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_currentTimeLabel.snp.right).offset(10).priority(750)
            make.height.equalTo(30)
        }
    }
    
    fileprivate func setProgressViewConstraints() {
        _progressView.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(_timeSlider)
            make.height.equalTo(2)
        }
    }
    
    fileprivate func setRemainingLabelConstraints() {
        _remainingTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_timeSlider.snp.right).offset(10)
            make.width.equalTo(40)
        }
    }
    
    fileprivate func setDurationLabelContraints() {
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
    public var fullScreenButton: UIButton? { get { return  _fullScreenButton } }
    
    public var timeSlider: UISlider? { get { return  _timeSlider } }
    public var progressView: UIProgressView? { get { return  _progressView } }
    
    public var controlView: UIView { return self }
    
    public func updateUI(_ isForFullScreen: Bool) {
        isFullScreen = isForFullScreen
        if isForFullScreen {
            updateFullScreenImage()
        } else {
            updateSmallScreenImage()
        }
    }
    
    fileprivate func updateFullScreenImage() {
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("SHVideoPlayer_fullscreen"), for: UIControlState())
        }
    }
    
    fileprivate func updateSmallScreenImage() {
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            _fullScreenButton.setImage(SHVideoPlayerUtils.resourceImagePath("SHVideoPlayer_smallscreen"), for: UIControlState())
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
        bgContainerView.backgroundColor = SHVideoPlayerUtils.clearShadeColor()
    }
    
    public func showPlayToTheEndView() {
        _playButton.isHidden = false
    }
}

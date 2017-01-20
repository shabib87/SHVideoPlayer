//
//  SHVideoPlayerWithDefaultControlsView.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit
import SnapKit

class SHVideoPlayerWithDefaultControlsView: UIView, SHVideoPlayerDefaultControlsCustomizationProtocol {
    
    weak var delegate: SHVideoPlayerDefaultControlsCustomizationDelegate?
    
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
    
    required init?(coder aDecoder: NSCoder) {
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
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonNormalStateImage(), for: UIControlState())
        } else {
            _playButton.setImage(SHImageResourcePath("SHVideoPlayer_play"), for: UIControlState())
        }
        
        if delegate != nil {
            _playButton.setImage(delegate?.playButtonSelectedStateImage(), for: UIControlState())
        } else {
            _playButton.setImage(SHImageResourcePath("SHVideoPlayer_pause"), for: UIControlState.selected)
        }
        
        if delegate != nil {
            _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            _fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_fullscreen"), for: UIControlState())
        }
    }
    
    fileprivate func configureLabels() {
        _titleLabel.textColor = UIColor.white
        _titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        _currentTimeLabel.textColor = UIColor.white
        _currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _currentTimeLabel.text = "00:00"
        _currentTimeLabel.textAlignment = .center
        
        _remainingTimeLabel.textColor = UIColor.white
        _remainingTimeLabel.font = UIFont.systemFont(ofSize: 12)
        _remainingTimeLabel.text = "00:00"
        _remainingTimeLabel.textAlignment = .right
        
        _durationLabel.textColor = UIColor.white
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
        _progressView.tintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
        _progressView.trackTintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3 )
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
        bgContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        topContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bgContainerView)
            make.height.equalTo(65)
        }
        
        bottomContainerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bgContainerView)
            make.height.equalTo(50)
        }
        
        _titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topContainerView.snp.left).offset(10)
            make.centerY.equalTo(topContainerView)
        }
        
        _fullScreenButton.snp.makeConstraints { (make) in
            make.width.equalTo(37)
            make.height.equalTo(42)
            make.centerY.equalTo(_titleLabel)
            make.left.equalTo(_titleLabel.snp.right).offset(10)
            make.right.equalTo(topContainerView.snp.right).offset(-10)
        }
        
        _playButton.snp.makeConstraints { (make) in
            make.width.equalTo(42)
            make.height.equalTo(42)
            make.centerX.centerY.equalTo(self)
        }
        
        _currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomContainerView.snp.left).offset(10)
            make.centerY.equalTo(bottomContainerView)
            make.width.equalTo(40)
        }
        
        _timeSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_currentTimeLabel.snp.right).offset(10).priority(750)
            make.height.equalTo(30)
        }
        
        _progressView.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(_timeSlider)
            make.height.equalTo(2)
        }
        
        _remainingTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_timeSlider.snp.right).offset(10)
            make.width.equalTo(40)
        }
        
        _durationLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(_currentTimeLabel)
            make.left.equalTo(_remainingTimeLabel.snp.right).offset(0)
            make.width.equalTo(40)
            make.right.equalTo(bottomContainerView.snp.right).offset(-10)
        }
    }
    
    fileprivate func SHImageResourcePath(_ fileName: String) -> UIImage? {
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "SHVideoPlayer", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let image = UIImage(named: fileName, in: bundle, compatibleWith: nil)
                return image
            }else {
                assertionFailure("Could not load the bundle")
            }
        }else {
            assertionFailure("Could not create a path to the bundle")
        }
        return nil
    }
}

extension SHVideoPlayerWithDefaultControlsView: SHVideoPlayerControlable {
    
    var titleLabel: UILabel?  { get { return  _titleLabel } }
    var currentTimeLabel: UILabel?  { get { return  _currentTimeLabel } }
    var durationLabel: UILabel?  { get { return  _durationLabel } }
    var remainingTimeLabel: UILabel? { get { return _remainingTimeLabel} }
    
    var playButton: UIButton? { get { return  _playButton } }
    var fullScreenButton: UIButton? { get { return  _fullScreenButton } }
    
    var timeSlider: UISlider? { get { return  _timeSlider } }
    var progressView: UIProgressView? { get { return  _progressView } }
    
    var playerControlView: UIView { return self }
    
    func updateUI(_ isForFullScreen: Bool) {
        isFullScreen = isForFullScreen
        if isForFullScreen {
            if delegate != nil {
                _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
            } else {
                _fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_fullscreen"), for: UIControlState())
            }
        } else {
            if delegate != nil {
                _fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
            } else {
                _fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_smallscreen"), for: UIControlState())
            }
        }
    }
    
    func showPlayerUIComponents() {
        _playButton.isHidden = false
        topContainerView.alpha    = 1.0
        bottomContainerView.alpha = 1.0
        bgContainerView.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
    }
    
    func hidePlayerUIComponents() {
        _playButton.isHidden = true
        topContainerView.alpha = 0.0
        bottomContainerView.alpha = 0.0
        bgContainerView.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0 )
    }
    
    func showPlayToTheEndView() {
        _playButton.isHidden = false
    }
}

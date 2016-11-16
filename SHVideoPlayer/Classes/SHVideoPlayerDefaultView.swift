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
    
    var titleLabel = UILabel()
    var currentTimeLabel = UILabel()
    var totalTimeLabel = UILabel()
    var remainingTimeLabel = UILabel()
    
    
    var playButton = UIButton(type: .custom)
    var fullScreenButton = UIButton(type: .custom)
    
    var timeSlider = UISlider()
    var progressView = UIProgressView()
    
    var bgContainerView = UIView()
    var topContainerView = UIView()
    var bottomContainerView = UIView()
    
    var loadingIndector = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
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
    
    fileprivate func initUIComponents() {
        self.addSubview(bgContainerView)
        bgContainerView.addSubview(topContainerView)
        bgContainerView.addSubview(bottomContainerView)
        bgContainerView.addSubview(loadingIndector)
        bgContainerView.addSubview(playButton)
        
        topContainerView.addSubview(titleLabel)
        topContainerView.addSubview(fullScreenButton)
        
        bottomContainerView.addSubview(currentTimeLabel)
        bottomContainerView.addSubview(remainingTimeLabel)
        bottomContainerView.addSubview(totalTimeLabel)
        bottomContainerView.addSubview(progressView)
        bottomContainerView.addSubview(timeSlider)
        
        bgContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        topContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        bottomContainerView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        if delegate != nil {
            playButton.setImage(delegate?.playButtonNormalStateImage(), for: UIControlState())
        } else {
            playButton.setImage(SHImageResourcePath("SHVideoPlayer_play"), for: UIControlState())
        }
        
        if delegate != nil {
            playButton.setImage(delegate?.playButtonSelectedStateImage(), for: UIControlState())
        } else {
            playButton.setImage(SHImageResourcePath("SHVideoPlayer_pause"), for: UIControlState.selected)
        }
        
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        currentTimeLabel.textColor = UIColor.white
        currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        currentTimeLabel.text = "00:00"
        currentTimeLabel.textAlignment = .center
        
        remainingTimeLabel.textColor = UIColor.white
        remainingTimeLabel.font = UIFont.systemFont(ofSize: 12)
        remainingTimeLabel.text = "00:00"
        remainingTimeLabel.textAlignment = .right
        
        totalTimeLabel.textColor = UIColor.white
        totalTimeLabel.font = UIFont.systemFont(ofSize: 12)
        totalTimeLabel.text = "/00:00"
        totalTimeLabel.textAlignment = .left
        
        timeSlider.maximumValue = 1.0
        timeSlider.minimumValue = 0.0
        timeSlider.value = 0.0
        timeSlider.maximumTrackTintColor = .clear
        timeSlider.minimumTrackTintColor = .white
        
        progressView.tintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
        progressView.trackTintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3 )
        
        loadingIndector.hidesWhenStopped = true
        
        if delegate != nil {
            fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
        } else {
            fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_fullscreen"), for: UIControlState())
        }
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
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topContainerView.snp.left).offset(10)
            make.centerY.equalTo(topContainerView)
        }
        
        fullScreenButton.snp.makeConstraints { (make) in
            make.width.equalTo(37)
            make.height.equalTo(42)
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(topContainerView.snp.right).offset(-10)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.width.equalTo(42)
            make.height.equalTo(42)
            make.centerX.centerY.equalTo(self)
        }
        
        currentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomContainerView.snp.left).offset(10)
            make.centerY.equalTo(bottomContainerView)
            make.width.equalTo(40)
        }
        
        timeSlider.snp.makeConstraints { (make) in
            make.centerY.equalTo(currentTimeLabel)
            make.left.equalTo(currentTimeLabel.snp.right).offset(10).priority(750)
            make.height.equalTo(30)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.centerY.left.right.equalTo(timeSlider)
            make.height.equalTo(2)
        }
        
        remainingTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(currentTimeLabel)
            make.left.equalTo(timeSlider.snp.right).offset(10)
            make.width.equalTo(40)
        }
        
        totalTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(currentTimeLabel)
            make.left.equalTo(remainingTimeLabel.snp.right).offset(0)
            make.width.equalTo(40)
            make.right.equalTo(bottomContainerView.snp.right).offset(-10)
        }
        
        loadingIndector.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgContainerView.snp.centerX).offset(0)
            make.centerY.equalTo(bgContainerView.snp.centerY).offset(0)
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
    
    var playerTitleLabel: UILabel?  { get { return  titleLabel } }
    var playerCurrentTimeLabel: UILabel?  { get { return  currentTimeLabel } }
    var playerTotalTimeLabel: UILabel?  { get { return  totalTimeLabel } }
    var playerRemainingTimeLabel: UILabel? { get { return remainingTimeLabel} }
    
    var playerPlayButton: UIButton? { get { return  playButton } }
    var playerFullScreenButton: UIButton? { get { return  fullScreenButton } }
    
    var playerTimeSlider: UISlider? { get { return  timeSlider } }
    var playerProgressView: UIProgressView? { get { return  progressView } }
    
    var playerControlView: UIView { return self }
    
    func updateUI(_ isForFullScreen: Bool) {
        isFullScreen = isForFullScreen
        if isForFullScreen {
            if delegate != nil {
                fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
            } else {
                fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_fullscreen"), for: UIControlState())
            }
        } else {
            if delegate != nil {
                fullScreenButton.setImage(delegate?.fullScreenButtonImage(), for: UIControlState())
            } else {
                fullScreenButton.setImage(SHImageResourcePath("SHVideoPlayer_smallscreen"), for: UIControlState())
            }
        }
    }
    
    func showLoader() {
        loadingIndector.isHidden = false
        loadingIndector.startAnimating()
    }
    
    func hideLoader() {
        loadingIndector.isHidden = true
    }
    
    func showPlayerUIComponents() {
        playButton.isHidden = false
        topContainerView.alpha    = 1.0
        bottomContainerView.alpha = 1.0
        bgContainerView.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
    }
    
    func hidePlayerUIComponents() {
        playButton.isHidden = true
        topContainerView.alpha = 0.0
        bottomContainerView.alpha = 0.0
        bgContainerView.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0 )
    }
    
    func showPlayToTheEndView() {
        playButton.isHidden = false
    }
}

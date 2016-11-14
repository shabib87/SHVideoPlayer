//
//  SHVideoPlayerView.swift
//  Pods
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit
import SnapKit

class SHVideoPlayerView: UIView {
    
    var titleLabel = UILabel()
    var currentTimeLabel = UILabel()
    var totalTimeLabel = UILabel()
    
    var playButton = UIButton(type: .custom)
    var fullScreenButton = UIButton(type: .custom)
    
    var timeSlider = UISlider()
    var progressView = UIProgressView()
    
    var bgMaskView = UIView()
    
    var topMaskView     = UIView()
    var bottomMaskView  = UIView()
    var maskImageView   = UIImageView()
    var loadingIndector  = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
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
        self.addSubview(bgMaskView)
        bgMaskView.addSubview(topMaskView)
        bgMaskView.addSubview(bottomMaskView)
        bgMaskView.insertSubview(maskImageView, at: 0)
        bgMaskView.addSubview(loadingIndector)
        bgMaskView.addSubview(playButton)
        
        topMaskView.addSubview(titleLabel)
        topMaskView.addSubview(fullScreenButton)
        
        bottomMaskView.addSubview(currentTimeLabel)
        bottomMaskView.addSubview(totalTimeLabel)
        bottomMaskView.addSubview(progressView)
        bottomMaskView.addSubview(timeSlider)
        
        bgMaskView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        
        playButton.setImage(SHImageResourcePath("BMPlayer_play"), for: UIControlState())
        playButton.setImage(SHImageResourcePath("BMPlayer_pause"), for: UIControlState.selected)
        
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        currentTimeLabel.textColor = UIColor.white
        currentTimeLabel.font = UIFont.systemFont(ofSize: 12)
        currentTimeLabel.text = "00:00"
        currentTimeLabel.textAlignment = .center
        
        totalTimeLabel.textColor = UIColor.white
        totalTimeLabel.font = UIFont.systemFont(ofSize: 12)
        totalTimeLabel.text = "00:00"
        totalTimeLabel.textAlignment = .center
        
        timeSlider.maximumValue = 1.0
        timeSlider.minimumValue = 0.0
        timeSlider.value = 0.0
        timeSlider.setThumbImage(SHImageResourcePath("BMPlayer_slider_thumb"), for: UIControlState())
        
        timeSlider.maximumTrackTintColor = .clear
        timeSlider.minimumTrackTintColor = .white
        
        progressView.tintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
        progressView.trackTintColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3 )
        
        fullScreenButton.setImage(SHImageResourcePath("BMPlayer_fullscreen"), for: UIControlState())
    }
    
    fileprivate func addConstraintsToComponents() {
        bgMaskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        maskImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgMaskView)
        }
        
        topMaskView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(bgMaskView)
            make.height.equalTo(65)
        }
        
        bottomMaskView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(bgMaskView)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topMaskView.snp.left)
            make.centerY.equalTo(topMaskView)
        }
        
        fullScreenButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalTo(topMaskView.snp.right)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.centerY.equalTo(self)
        }
        
        currentTimeLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(bottomMaskView)
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
        
        totalTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(currentTimeLabel)
            make.left.equalTo(timeSlider.snp.right).offset(5)
            make.width.equalTo(40)
            make.right.equalTo(bottomMaskView.snp.right)
        }
        
        loadingIndector.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgMaskView.snp.centerX).offset(0)
            make.centerY.equalTo(bgMaskView.snp.centerY).offset(0)
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

extension SHVideoPlayerView: SHPlayerControlView {
    
    var playerTitleLabel        : UILabel?  { get { return  titleLabel } }
    var playerCurrentTimeLabel  : UILabel?  { get { return  currentTimeLabel } }
    var playerTotalTimeLabel    : UILabel?  { get { return  totalTimeLabel } }
    
    var playerPlayButton        : UIButton? { get { return  playButton } }
    var playerFullScreenButton  : UIButton? { get { return  fullScreenButton } }
    
    var playerTimeSlider        : UISlider? { get { return  timeSlider } }
    var playerProgressView      : UIProgressView? { get { return  progressView } }
    
    var playerControlView: UIView { return self }
    
    func updateUI(_ isForFullScreen: Bool) {
        
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func showPlayerUIComponents() {
        
    }
    
    func hidePlayerUIComponents() {
        
    }
    
    func showPlayToTheEndView() {
        
    }
    
    func showSeekToView(_ to:TimeInterval, isForwarded: Bool) {
        
    }
    
    func hideSeekToView() {
        
    }
    
    func showCoverWithLink(_ cover:String) {
        
    }
    
    func hideCoverImageView() {
        
    }
}

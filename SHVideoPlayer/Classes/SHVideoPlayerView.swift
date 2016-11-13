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
        bgMaskView.addSubview(playButton)
        bgMaskView.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4 )
        
    }
    
    fileprivate func addConstraintsToComponents() {
        bgMaskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        playButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.centerX.centerY.equalTo(self)
        }
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

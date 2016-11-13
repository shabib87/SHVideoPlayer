//
//  SHVideoPlayerViewProtocols.swift
//  Pods
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit

public protocol SHPlayerControlView  {
    
    var playerTitleLabel        : UILabel?  { get }
    var playerCurrentTimeLabel  : UILabel?  { get }
    var playerTotalTimeLabel    : UILabel?  { get }
    
    var playerPlayButton        : UIButton? { get }
    var playerFullScreenButton  : UIButton? { get }
    
    var playerTimeSlider        : UISlider? { get }
    var playerProgressView      : UIProgressView? { get }
    
    var playerControlView : UIView { get }
    
    /**
     call when UI needs to update, usually when screen orient did change
     
     - parameter isForFullScreen: is fullscreen
     */
    func updateUI(_ isForFullScreen: Bool)
    
    /**
     call when buffering
     */
    func showLoader()
    
    /**
     call when buffer finished
     */
    func hideLoader()
    
    /**
     call when user tapped on player to show player Ui components
     */
    func showPlayerUIComponents()
    
    /**
     call when user tapped on player to hide player Ui components
     */
    func hidePlayerUIComponents()
    
    /**
     call when video play did end
     */
    func showPlayToTheEndView()
    
    /**
     call when user slide to seek
     
     - parameter to:    target time
     - parameter isForwarded: is slide to right
     */
    func showSeekToView(_ to:TimeInterval, isForwarded: Bool)
    /**
     call when seek info view should hide
     */
    func hideSeekToView()
    
    /**
     call when needs to show cover image
     
     - parameter cover: cover url
     */
    func showCoverWithLink(_ cover:String)
    
    /**
     call when needs to hide cover image
     */
    func hideCoverImageView()
}

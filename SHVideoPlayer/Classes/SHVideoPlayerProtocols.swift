//
//  SHVideoPlayerProtocols.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit

public protocol SHVideoPlayerDefaultControlsCustomizationDelegate: class {
    
    func playButtonNormalStateImage()-> UIImage
    func playButtonSelectedStateImage()-> UIImage
    
    func pauseButtonNormalStateImage()-> UIImage
    func pauseButtonSelectedStateImage()-> UIImage
    
    func fullScreenButtonImage()-> UIImage
    func smallScreenButtonImage()-> UIImage
}

public protocol SHVideoPlayerDefaultControlsCustomizationProtocol {
    
    weak var delegate: SHVideoPlayerDefaultControlsCustomizationDelegate? { get set }
}

public protocol SHVideoPlayerControlable  {
    
    var playerTitleLabel: UILabel?  { get }
    var playerCurrentTimeLabel: UILabel?  { get }
    var playerRemainingTimeLabel: UILabel?  { get }
    var playerTotalTimeLabel: UILabel?  { get }
    
    var playerPlayButton: UIButton? { get }
    var playerFullScreenButton: UIButton? { get }
    
    var playerTimeSlider: UISlider? { get }
    var playerProgressView: UIProgressView? { get }
    
    var playerControlView: UIView { get }
    
    /**
     call when UI needs to update, usually when screen orient did change
     
     - parameter isForFullScreen: is fullscreen
     */
    func updateUI(_ isForFullScreen: Bool)
    
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
}

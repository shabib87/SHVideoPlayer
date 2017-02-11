//
//  SHVideoPlayerProtocols.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import UIKit

public protocol SHVideoPlayerScrubberDelegate: class {
    func playerStateDidChange(isPlaying: Bool)
}

public protocol SHVideoPlayerDefaultControlCustomizationDelegate: class {
    
    func playButtonNormalStateImage()-> UIImage
    func playButtonSelectedStateImage()-> UIImage
    
    func pauseButtonNormalStateImage()-> UIImage
    func pauseButtonSelectedStateImage()-> UIImage
    
    func backButtonImage()-> UIImage
    func fullScreenButtonImage()-> UIImage
    func smallScreenButtonImage()-> UIImage
}

public protocol SHVideoPlayerDefaultControlsCustomizationProtocol {
    
    weak var delegate: SHVideoPlayerDefaultControlCustomizationDelegate? { get set }
}

public protocol SHVideoPlayerControl  {
    
    var titleLabel: UILabel?  { get }
    var currentTimeLabel: UILabel?  { get }
    var remainingTimeLabel: UILabel?  { get }
    var durationLabel: UILabel?  { get }
    
    var playButton: UIButton? { get }
    var backButton: UIButton? { get }
    var fullScreenButton: UIButton? { get }
    
    var timeSlider: UISlider? { get }
    var progressView: UIProgressView? { get }
    
    var controlView: UIView { get }
    
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

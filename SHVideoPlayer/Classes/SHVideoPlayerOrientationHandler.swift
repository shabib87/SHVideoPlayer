//
//  SHVideoPlayerOrientationHandler.swift
//  Pods
//
//  Created by shabib hossain on 2/11/17.
//
//

import Foundation
import UIKit

public class SHVideoPlayerOrientationHandler {
    
    public var isFullScreen:Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    fileprivate var playerControl: SHVideoPlayerControl!
    
    init(playerControlView playerControl: SHVideoPlayerControl) {
        self.playerControl = playerControl
        playerControl.fullScreenButton?.addTarget(self, action: #selector(self.fullScreenAction(_:)), for: UIControlEvents.touchUpInside)
        playerControl.updateUI(!self.isFullScreen)
    }
    
    @objc fileprivate func fullScreenAction(_ button: Any?) {
        playerControl.updateUI(!self.isFullScreen)
        if isFullScreen {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIApplication.shared.isStatusBarHidden = false
            UIApplication.shared.statusBarOrientation = .portrait
        } else {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.isStatusBarHidden = false
            UIApplication.shared.statusBarOrientation = .landscapeRight
        }
    }
}

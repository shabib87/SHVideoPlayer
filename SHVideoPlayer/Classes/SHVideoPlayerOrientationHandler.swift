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
    
    public var isFullScreen: Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    fileprivate var playerControl: SHVideoPlayerControl!
    
    init(playerControlView playerControl: SHVideoPlayerControl) {
        self.playerControl = playerControl
        self.addPlayerControlFullScreenButtonAction()
        self.addOrientationChangedNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    fileprivate func addPlayerControlFullScreenButtonAction() {
        playerControl.fullScreenButton?.addTarget(self, action: #selector(self.fullScreenAction(_:)), for: UIControlEvents.touchUpInside)
        playerControl.updateUI(!isFullScreen)
    }
    
    fileprivate func addOrientationChangedNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onOrientationChanged), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    @objc fileprivate func onOrientationChanged(_ isFullScreen: Bool) {
        playerControl.updateUI(isFullScreen)
    }
    
    @objc fileprivate func fullScreenAction(_ button: Any?) {
        playerControl.updateUI(!isFullScreen)
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

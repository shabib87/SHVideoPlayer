//
//  SHVideoPlayerOrientationHandler.swift
//  Pods
//
//  Created by shabib hossain on 2/11/17.
//
//

import Foundation
import UIKit

final class SHVideoPlayerOrientationHandler {
    
    public var isLandscape: Bool {
        get {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    private var playerControl: SHVideoPlayerControl!
    
    init(playerControlView playerControl: SHVideoPlayerControl) {
        self.playerControl = playerControl
        self.addPlayerControlFullScreenButtonAction()
        self.addOrientationChangedNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    private func addPlayerControlFullScreenButtonAction() {
        playerControl.fullScreenButton?.addTarget(self, action: #selector(self.fullScreenAction(_:)), for: .touchUpInside)
        playerControl.updateUI(!isLandscape)
    }
    
    private func addOrientationChangedNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onOrientationChanged), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    @objc private func onOrientationChanged() {
        playerControl.updateUI(!isLandscape)
    }
    
    @objc private func fullScreenAction(_ button: Any?) {
        playerControl.updateUI(!isLandscape)
        if isLandscape {
            rotatePortraitAction()
        } else {
            rotateLandscapeAction()
        }
    }
    
    private func rotatePortraitAction() {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarOrientation = .portrait
    }
    
    private func rotateLandscapeAction() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarOrientation = .landscapeRight
    }
}

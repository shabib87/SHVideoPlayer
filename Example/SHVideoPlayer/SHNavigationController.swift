//
//  SHNavigationController.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 2/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SHNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

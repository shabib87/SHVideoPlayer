//
//  SHVideoPlayerUtils.swift
//  Pods
//
//  Created by shabib hossain on 2/11/17.
//
//

import Foundation

struct SHVideoPlayerConstants {
    
    struct ObserverKey {
        static let duration = "kDurationKey"
    }
}

class SHVideoPlayerUtils: NSObject {
    
    class func resourceImagePath(_ fileName: String) -> UIImage? {
        let podBundle = Bundle(for: self.classForCoder())
        if let bundleURL = podBundle.url(forResource: "SHVideoPlayer", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let image = UIImage(named: fileName, in: bundle, compatibleWith: nil)
                return image
            } else {
                assertionFailure("Could not load the bundle")
            }
        } else {
            assertionFailure("Could not create a path to the bundle")
        }
        return nil
    }
    
    class func progressBarTintColor() -> UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
    }
    
    class func progressTrackTintColor() -> UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    
    class func blackShadeColor() -> UIColor {
        return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
    }
}

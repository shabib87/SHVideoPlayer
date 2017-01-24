//
//  SHVideo.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 1/22/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

struct SHVideo {
    var title: String?
    var url: String?
    var sourceURL: String?
    var thumbImage: UIImage?
    
    init(title: String, url: String, sourceURL: String) {
        self.title = title
        self.url = url
        self.sourceURL = url
        self.thumbImage = UIImage(named: title)
    }
}

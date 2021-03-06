//
//  DefaultPlayerVC.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//  Copyright (c) 2016 shabib87. All rights reserved.
//

import UIKit
import SHVideoPlayer

class DefaultPlayerVC: UIViewController {
    
    @IBOutlet var videoPlayer: SHVideoPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer.backActionCompletionHandler = {() in
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let path = Bundle.main.path(forResource: "RougeOneTrailer", ofType:"mp4") {
            let url = NSURL(fileURLWithPath: path)
            videoPlayer.playWithURL(url as URL, title: "Rogue One: A Star Wars Story")
        }
    }
}

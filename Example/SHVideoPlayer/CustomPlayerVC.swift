//
//  CustomPlayerVC.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 5/8/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SHVideoPlayer

class CustomPlayerVC: UIViewController {
    
    @IBOutlet var playerContainer: UIView!
    private var videoPlayer: SHVideoPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customPlayerControl = SHVideoPlayerCustomControl()
        videoPlayer = SHVideoPlayer(playerControl: customPlayerControl)
        playerContainer.addSubview(videoPlayer)
        self.layoutVideoPlayer()
        videoPlayer.backActionCompletionHandler = {() in
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func layoutVideoPlayer() {
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.leadingAnchor.constraint(equalTo: playerContainer.leadingAnchor).isActive = true
        videoPlayer.trailingAnchor.constraint(equalTo: playerContainer.trailingAnchor).isActive = true
        videoPlayer.topAnchor.constraint(equalTo: playerContainer.topAnchor).isActive = true
        videoPlayer.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let path = Bundle.main.path(forResource: "RougeOneTrailer", ofType:"mp4") {
            let url = NSURL(fileURLWithPath: path)
            videoPlayer.playWithURL(url as URL, title: "Rogue One: A Star Wars Story")
        }
    }
}

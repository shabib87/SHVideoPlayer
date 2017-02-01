//
//  ViewController.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//  Copyright (c) 2016 shabib87. All rights reserved.
//

import UIKit
import SHVideoPlayer

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var videoPlayer: SHVideoPlayer!
    fileprivate var videos: [SHVideo] = VideoDataSource.getModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let video = videos[0]
        videoPlayer.playWithURL(URL(string: video.url!)!)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCellID", for: indexPath) as! VideoTableViewCell
        let video = videos[indexPath.row]
        cell.titleLabel.text = video.title
        cell.sourceURLLabel.text = video.sourceURL
        cell.thumbImageView.image = video.thumbImage
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

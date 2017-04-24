//
//  CustomPlayerVC.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 2/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SHVideoPlayer

class CustomPlayerVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var videoPlayer: SHVideoPlayer!
    fileprivate var videos: [SHVideo?] = VideoDataSource.getModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoPlayer.backActionCompletionHandler = {() in
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let video = videos[1] else {
            return
        }
        videoPlayerPlayVideo(video: video)
    }
    
    fileprivate func videoPlayerPlayVideo(video: SHVideo) {
        guard let sourceURL = video.sourceURL else {
            return
        }
        
        guard let url =  URL(string: sourceURL),
            let title = video.title else {
                return
        }
        videoPlayer.playWithURL(url, title: title)
    }
}

extension CustomPlayerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCellID", for: indexPath) as! VideoTableViewCell
        if let video = videos[indexPath.row] {
            cell.titleLabel.text = video.title
            cell.sourceURLLabel.text = video.sourceURL
            cell.thumbImageView.image = video.thumbImage
        }
        return cell
    }
}

extension CustomPlayerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        guard let video = videos[indexPath.row] else {
            return
        }
        videoPlayerPlayVideo(video: video)
    }
}

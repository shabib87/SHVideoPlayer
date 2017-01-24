//
//  VideoDataSource.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 1/25/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

/*
 Source: https://videos.pexels.com
 
 1. https://player.vimeo.com/external/159035843.hd.mp4?s=d322529c7bf7f6638f992970fa01119eea37151f&profile_id=119&oauth2_token_id=57447761 (Person Working on an Apple MacBook, https://videos.pexels.com/videos/person-working-on-an-apple-macbook-599)
 2. https://player.vimeo.com/external/189415767.hd.mp4?s=4b8420413cb383c7198350dd1f71a4b54c175bfd&profile_id=174&oauth2_token_id=57447761 (People Partying, https://videos.pexels.com/videos/people-partying-1218)
 3. https://player.vimeo.com/external/180185916.hd.mp4?s=333d7b459ceb3c734a343c3bd63ecb29f453cfac&profile_id=174&oauth2_token_id=57447761 (Camping At A Forest, https://videos.pexels.com/videos/camping-at-a-forest-988)
 4. https://player.vimeo.com/external/137630144.hd.mp4?s=70bf7278ed6ea3eddca2449eda8aa8642aa9906f&profile_id=119&oauth2_token_id=57447761 (Planes on Airport, https://videos.pexels.com/videos/planes-on-airport-581)
 5. https://player.vimeo.com/external/123483208.hd.mp4?s=5048f108225289a3daa3f165a407e0b68010e799&profile_id=113&oauth2_token_id=57447761 (Timelapse of Stockholm at Night, https://videos.pexels.com/videos/timelapse-of-stockholm-at-night-539)
 */

class VideoDataSource {
    static func getModel() -> [SHVideo] {
        let model1 = SHVideo(title: "Person Working on an Apple MacBook", url: "https://player.vimeo.com/external/159035843.hd.mp4?s=d322529c7bf7f6638f992970fa01119eea37151f&profile_id=119&oauth2_token_id=57447761", sourceURL: "https://videos.pexels.com/videos/person-working-on-an-apple-macbook-599")
        let model2 = SHVideo(title: "People Partying", url: "https://player.vimeo.com/external/189415767.hd.mp4?s=4b8420413cb383c7198350dd1f71a4b54c175bfd&profile_id=174&oauth2_token_id=57447761", sourceURL: "https://videos.pexels.com/videos/people-partying-1218")
        let model3 = SHVideo(title: "Camping At A Forest", url: "https://player.vimeo.com/external/180185916.hd.mp4?s=333d7b459ceb3c734a343c3bd63ecb29f453cfac&profile_id=174&oauth2_token_id=57447761", sourceURL: "https://videos.pexels.com/videos/camping-at-a-forest-988")
        let model4 = SHVideo(title: "Planes on Airport", url: "https://player.vimeo.com/external/137630144.hd.mp4?s=70bf7278ed6ea3eddca2449eda8aa8642aa9906f&profile_id=119&oauth2_token_id=57447761", sourceURL: "https://videos.pexels.com/videos/planes-on-airport-581")
        let model5 = SHVideo(title: "Timelapse of Stockholm at Night", url: "https://player.vimeo.com/external/123483208.hd.mp4?s=5048f108225289a3daa3f165a407e0b68010e799&profile_id=113&oauth2_token_id=57447761", sourceURL: "https://videos.pexels.com/videos/timelapse-of-stockholm-at-night-539")
        return [model1, model2, model3, model4, model5]
    }
}

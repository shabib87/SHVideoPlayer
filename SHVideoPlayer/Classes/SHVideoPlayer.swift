//
//  SHVideoPlayer.swift
//  SHVideoPlayer
//
//  Created by shabib hossain on 11/13/16.
//
//

import Foundation
import SnapKit

open class SHVideoPlayer: UIView {
    
    open var tapGesture: UITapGestureRecognizer!
    fileprivate var playerControllerView: SHVideoPlayerControlable!
    fileprivate var playerLayer: SHVideoPlayerLayerView!
    
    convenience init(withControllerView playerControllerView: SHVideoPlayerControlable) {
        super.init()
        self.playerControllerView = playerControllerView
    }
    
    init() {
        self.playerControllerView = SHVideoPlayerWithDefaultControlsView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

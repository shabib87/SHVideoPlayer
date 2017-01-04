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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init (customControllView: SHVideoPlayerControlable?) {
        self.init(frame:CGRect.zero)
        self.playerControllerView = customControllView
    }
    
    public convenience init() {
        self.init(customControllView:nil)
    }
    
    deinit {
        
    }
}

//
//  RadioAPI.swift
//  OtterRadio
//
//  Created by Mario Martinez on 3/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import AVFoundation

class RadioAPI {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    let radioURL = "http://icecast.csumb.edu:8000/ottermedia"

    init() {
        let url = URL(string: radioURL)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
    }
    
    
}

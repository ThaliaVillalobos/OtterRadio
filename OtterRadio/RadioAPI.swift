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
    var playerLayer:AVPlayerLayer
    let radioURL = "http://icecast.csumb.edu:8000/ottermedia"
    var isPlaying:Bool?

    init() {
        let url = URL(string: radioURL)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:50, height:50)
        isPlaying = false

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func initPlayer() {
        let url = URL(string: radioURL)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)

    }
    
    func getAVPlayerLayer() -> AVPlayerLayer {
        return playerLayer
    }
    
    func getAVPlayer() -> AVPlayer {
        return player!
    }
    
    func RadioIsPlaying() -> Bool {
        return isPlaying!
    }
    
    func playRadio() {
        if player != nil {
            player!.play()
        }else{
            self.initPlayer()
            player!.play()
        }
        isPlaying = true
    }
    
    func stopRadio() {
        if player != nil {
            player!.pause()
            player = nil
        }
        isPlaying = false
    }
}

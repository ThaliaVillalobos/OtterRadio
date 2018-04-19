//
//  RadioAPI.swift
//  OtterRadio
//
//  Created by Mario Martinez on 3/24/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class RadioAPI {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playerLayer:AVPlayerLayer
    let radioURL = "http://icecast.csumb.edu:8000/ottermedia"
    var isPlaying:Bool?

    init() {
        
        
        let url = URL(string: radioURL)
        if AVAsset(url: url!).isPlayable {
            print("The link is working")
        }else{
            print("Error: Radio link is down")
        }
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:50, height:50)
        isPlaying = false
        
        setupAVAudioSession()

    }
    
    private func setupAVAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("AVAudioSession is Active and Category Playback is set")
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupCommandCenter()
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
    private func setupCommandCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Otter Radio"]
        MPNowPlayingInfoCenter.default().nowPlayingInfo?.updateValue((player?.rate)!, forKey: MPNowPlayingInfoPropertyPlaybackRate)
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.playRadio()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.stopRadio()
            return .success
        }
    }
    
    func initPlayer() {
        let url = URL(string: radioURL)
        if AVAsset(url: url!).isPlayable {
            print("The link is working")
        }else{
            print("Error: Radio link is down")
        }
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
        MPNowPlayingInfoCenter.default().nowPlayingInfo?.updateValue((player?.rate)!, forKey: MPNowPlayingInfoPropertyPlaybackRate)

    }
    
    func stopRadio() {
        if player != nil {
            player!.pause()
            MPNowPlayingInfoCenter.default().nowPlayingInfo?.updateValue((player?.rate)!, forKey: MPNowPlayingInfoPropertyPlaybackRate)
            player = nil
        }
        isPlaying = false

    }
}

//
//  PlayerController.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Nuke

class PlayerController {
    
    static var player:AVPlayer?
    static var audioPlayerView = AudioPlayerView()
    static var audioPlayerBar = AudioPlayerBarView()
    static var podCastData: Podcast!
    static var playerItem:AVPlayerItem?
    static var updater : CADisplayLink! = nil
    
    static var isSliding = false
    static var isPlaying = false
    
    static func inicialize(podCastData: Podcast) {
        if self.podCastData == nil || self.podCastData.id != podCastData.id {
            self.podCastData = podCastData
            Nuke.loadImage(with: URL(string: podCastData.image ?? "")!, into: audioPlayerView.artImageView)
            Nuke.loadImage(with: URL(string: podCastData.image ?? "")!, into: audioPlayerBar.artImageView)
            audioPlayerView.durationLabel.text = formatTime(seconds: ((Double(podCastData.audio_length ?? 0))))
            audioPlayerView.timeLabel.text = "00:00:00"
            audioPlayerBar.timeLabel.text = "00:00:00/" +  formatTime(seconds: ((Double(podCastData.audio_length ?? 0))))
            audioPlayerBar.titleLabel.text = podCastData.title
            self.setupAudio()
            self.setupActions()
            self.setupSlider()
            player!.play()
            audioPlayerView.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            audioPlayerBar.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = true
        }
    }
    
    static func setupActions() {
        audioPlayerView.playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        audioPlayerBar.playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        audioPlayerView.advanceSecButton.addTarget(self, action: #selector(advanceSec), for: .touchDown)
        audioPlayerView.backSecButton.addTarget(self, action: #selector(backSec), for: .touchDown)
    }
    
    static func setupSlider() {
        audioPlayerView.progressBarSlider.minimumValue = 0
        
        
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        audioPlayerView.progressBarSlider.maximumValue = Float(seconds)
        audioPlayerView.progressBarSlider.isContinuous = true
        audioPlayerView.progressBarSlider.tintColor = UIColor.white
        audioPlayerView.progressBarSlider.minimumValue = 0
        audioPlayerView.progressBarSlider.maximumValue = 1
        
        audioPlayerView.progressBarSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        audioPlayerView.progressBarSlider.addTarget(self, action: #selector(slidingAction(_:)), for: .allEditingEvents)
        
        updater = CADisplayLink(target: self, selector: #selector(updateAudioProgressView))
        updater.preferredFramesPerSecond = Int(0.1)
    }
    
    static func setupAudio() {
        let url = URL(string: podCastData.audio ?? "")
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        //Now Playing
        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        
        let title = podCastData.title
        let album = podCastData.podcast?.publisher
        let artworkData = Data()
        let image = audioPlayerView.artImageView.image
        let artwork = MPMediaItemArtwork(boundsSize: image!.size, requestHandler: {  (_) -> UIImage in
            return image!
        })
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = album
        nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        
        let rcc = MPRemoteCommandCenter.shared()
        
        let stopCommand = rcc.pauseCommand
        stopCommand.isEnabled = true
        stopCommand.addTarget(handler: pauseAction)
        
        let resumeCommand = rcc.playCommand
        resumeCommand.isEnabled = true
        resumeCommand.addTarget(handler: pauseAction)
        
        let skipBackwardCommand = rcc.skipBackwardCommand
        skipBackwardCommand.isEnabled = true
        skipBackwardCommand.addTarget(handler: skipBackward)
        skipBackwardCommand.preferredIntervals = [10]
        
        let skipForwardCommand = rcc.skipForwardCommand
        skipForwardCommand.isEnabled = true
        skipForwardCommand.addTarget(handler: skipForward)
        skipForwardCommand.preferredIntervals = [10]
    }
    
    static func pauseAction(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        if player?.rate == 0
        {
            player!.play()
            audioPlayerView.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            audioPlayerBar.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = true
        } else if isPlaying {
            player!.pause()
            audioPlayerView.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            audioPlayerBar.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = false
        }
        return .success
    }
    
    static func skipBackward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        guard let command = event.command as? MPSkipIntervalCommand else {
            return .noSuchContent
        }
        backSec()
        return .success
    }
    
    static func skipForward(_ event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
        guard let command = event.command as? MPSkipIntervalCommand else {
            return .noSuchContent
        }
        advanceSec()
        return .success
    }
    
    @objc static func slidingAction(_ playbackSlider:UISlider)
    {
        isSliding = true
    }
    
    @objc static func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        let seconds : Double = (Double(audioPlayerView.progressBarSlider.value * 100))
        let result = ((player?.currentItem?.duration.seconds)! * seconds) / 100
        let targetTime:CMTime = CMTimeMake(value: Int64(result), timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
        isSliding = false
    }
    
    @objc static func advanceSec()
    {
        if isPlaying {
            let seconds : Double = (Double(audioPlayerView.progressBarSlider.value * 100))
            let result = ((player?.currentItem?.duration.seconds)! * seconds) / 100
            let targetTime:CMTime = CMTimeMake(value: Int64(result + 10), timescale: 1)
            
            player!.seek(to: targetTime)
            
            if player!.rate == 0
            {
                player?.play()
            }
        }
    }
    
    @objc static func backSec()
    {
        if isPlaying {
            let seconds : Double = (Double(audioPlayerView.progressBarSlider.value * 100))
            let result = ((player?.currentItem?.duration.seconds)! * seconds) / 100
            let targetTime:CMTime = CMTimeMake(value: Int64(result - 10), timescale: 1)
            
            player!.seek(to: targetTime)
            
            if player!.rate == 0
            {
                player?.play()
            }
        }
    }
    
    
    @objc static func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            audioPlayerView.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            audioPlayerBar.playButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = true
        } else if isPlaying {
            player!.pause()
            audioPlayerView.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            audioPlayerBar.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = false
        }
    }
    
    @objc static func updateAudioProgressView()
    {
        if !isSliding {
            let normalizedTime = Float((player?.currentTime().seconds)! * 100.0 / (player?.currentItem?.duration.seconds)!) / 100
            audioPlayerView.progressBarSlider.value = normalizedTime
        }
        let seconds = player?.currentTime().seconds
        audioPlayerView.timeLabel.text = formatTime(seconds: seconds!)
        audioPlayerBar.timeLabel.text = formatTime(seconds: seconds!) + "/" + formatTime(seconds: ((Double(podCastData.audio_length ?? 0))))
    }
    
    static func formatTime(seconds: Double) -> String {
        let time = secondsToHoursMinutesSeconds(seconds: Int(seconds))
        var hourAux = time.0.description
        var minutesAux = time.1.description
        var secondsAux = time.2.description
        if time.0 < 9 {
            hourAux = "0" + time.0.description
        }
        if time.1 < 9 {
            minutesAux = "0" + time.1.description
        }
        if time.2 < 9 {
            secondsAux = "0" + time.2.description
        }
        return hourAux + ":" + minutesAux + ":" + secondsAux
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

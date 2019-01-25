//
//  ViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 27/12/18.
//  Copyright © 2018 Vitor Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import Nuke

class PlayerViewController: CustomViewController  {
    
    var id = ""
    var podCastData: Podcast!
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    var updater : CADisplayLink! = nil
    
    var isSliding = false
    var isPlaying = false
    
    var audioPlayerView = AudioPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .done, target: self, action: #selector(performBack))
        loadData()
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    func loadData() {
        startLoad()
        PodCastListService.getBestPodById(id: id) { resultPodCast in
            if resultPodCast != nil {
                self.podCastData = resultPodCast
                self.setupViews()
                self.setupAudio()
                self.setupActions()
                self.setupSlider()
            }
            self.stopLoad()
        }
    }
    
    func setupViews() {
        view.addSubview(audioPlayerView)
        audioPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        audioPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        audioPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        Nuke.loadImage(with: URL(string: podCastData.image ?? "")!, into: audioPlayerView.artImageView)
        audioPlayerView.durationLabel.text = formatTime(seconds: ((Double(podCastData.audio_length ?? 0))))
        audioPlayerView.timeLabel.text = "00:00:00"
    }
    
    func setupActions() {
        audioPlayerView.playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        audioPlayerView.advanceSecButton.addTarget(self, action: #selector(advanceSec), for: .touchDown)
        audioPlayerView.backSecButton.addTarget(self, action: #selector(backSec), for: .touchDown)
    }
    
    func setupSlider() {
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
    
    func setupAudio() {
        let url = URL(string: podCastData.audio ?? "")
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    
    @objc func slidingAction(_ playbackSlider:UISlider)
    {
        isSliding = true
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
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
    
    @objc func advanceSec()
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
    
    @objc func backSec()
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
    
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            audioPlayerView.playButton.setImage(UIImage(named: "stop")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = true
        } else if isPlaying {
            player!.pause()
            audioPlayerView.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
            updater.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
            isPlaying = false
        }
    }
    
    @objc func updateAudioProgressView()
    {
        if !isSliding {
            let normalizedTime = Float((player?.currentTime().seconds)! * 100.0 / (player?.currentItem?.duration.seconds)!) / 100
            audioPlayerView.progressBarSlider.value = normalizedTime
        }
        let seconds = player?.currentTime().seconds
        audioPlayerView.timeLabel.text = formatTime(seconds: seconds!)
    }
    
    func formatTime(seconds: Double) -> String {
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
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}


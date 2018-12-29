import UIKit
import AVFoundation
import Nuke

class ViewController: UIViewController  {
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    var updater : CADisplayLink! = nil
    
    var audioPlayerView = AudioPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAudio()
        setupActions()
        setupSlider()
    }
    
    func setupViews() {
        view.addSubview(audioPlayerView)
        audioPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        audioPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        audioPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        Nuke.loadImage(with: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/7027eee6298a4d1387a243d1a901578c.jpg")!, into: audioPlayerView.artImageView)
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
        
        updater = CADisplayLink(target: self, selector: #selector(updateAudioProgressView))
        updater.frameInterval = 1
        updater.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        
    }
    
    func setupAudio() {
        let url = URL(string: "https://www.listennotes.com/e/p/a56476b08cc84fb5b90a236c3a920778/")
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    @objc func advanceSec()
    {
        let seconds : Int64 = Int64(audioPlayerView.progressBarSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds + 10, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    @objc func backSec()
    {
        let seconds : Int64 = Int64(audioPlayerView.progressBarSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds - 10, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    
    @objc func playButtonTapped(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            audioPlayerView.playButton.setImage(UIImage(named: "stop")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            player!.pause()
            audioPlayerView.playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    @objc func updateAudioProgressView()
    {
        var normalizedTime = Float((player?.currentTime().seconds)! * 100.0 / (player?.currentItem?.duration.seconds)!) / 100
        audioPlayerView.progressBarSlider.value = normalizedTime
        print(normalizedTime)
    }
    
}



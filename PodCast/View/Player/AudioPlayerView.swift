//
//  AudioBarControllerView.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/12/18.
//  Copyright © 2018 Vitor Mendes. All rights reserved.
//
import UIKit

class AudioPlayerView: UIView {
    
    let artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.secondary
        imageView.image = #imageLiteral(resourceName: "headphone").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.secondary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let advanceSecButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.secondary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backSecButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.secondary
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let progressBarSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.secondary
        var thumImage = UIImage.circle(diameter: 10, color: UIColor.secondary)
        slider.setThumbImage(thumImage, for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Identifier has not been implemeted")
    }
    
    func setupViews()
    {
        backgroundColor = UIColor.primary
        translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize = UIScreen.main.bounds.width - 120
        
        addSubview(artImageView)
        artImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        artImageView.topAnchor.constraint(equalTo: topAnchor, constant: 64).isActive = true
        artImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        artImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: artImageView.bottomAnchor, constant: 16).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        addSubview(backSecButton)
        backSecButton.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -16).isActive = true
        backSecButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        backSecButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backSecButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backSecButton.setImage(UIImage(named: "backSec")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        addSubview(advanceSecButton)
        advanceSecButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 16).isActive = true
        advanceSecButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        advanceSecButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        advanceSecButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        advanceSecButton.setImage(UIImage(named: "advanceSec")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        addSubview(progressBarSlider)
        progressBarSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 16).isActive = true
        progressBarSlider.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        progressBarSlider.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: progressBarSlider.bottomAnchor, constant: 16).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        addSubview(durationLabel)
        durationLabel.topAnchor.constraint(equalTo: progressBarSlider.bottomAnchor, constant: 16).isActive = true
        durationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        
    }
    
}

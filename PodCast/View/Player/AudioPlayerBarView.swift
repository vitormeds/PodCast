//
//  AudioPlayerBar.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import MarqueeLabel

class AudioPlayerBarView: UIView {
    
    let artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.marqueeType = MarqueeType.MLContinuous
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
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
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(closeButton)
        closeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(artImageView)
        artImageView.leftAnchor.constraint(equalTo: closeButton.rightAnchor, constant: 4).isActive = true
        artImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        artImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(playButton)
        playButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: artImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -8).isActive = true
        
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: artImageView.rightAnchor, constant: 8).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -8).isActive = true
        
    }
    
}

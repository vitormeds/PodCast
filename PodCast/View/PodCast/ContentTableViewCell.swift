//
//  ContentTableViewCell.swift
//  PodCast
//
//  Created by Vitor Mendes on 17/05/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

class ContentTableViewCell: UITableViewCell {
    
    var iconImageView: UIImageView = {
        let img = UIImageView()
        img.layer.zPosition = 2
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var iconDownload: UIImageView = {
        let img = UIImageView()
        img.tintColor = UIColor.white
        img.image = #imageLiteral(resourceName: "downloadIcon").withRenderingMode(.alwaysTemplate)
        img.layer.zPosition = 2
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.isUserInteractionEnabled = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let iconDownloadAnimation: LOTAnimationView = {
        let headerAnimationView = LOTAnimationView(name: "downloadPodCast")
        headerAnimationView.translatesAutoresizingMaskIntoConstraints = false
        headerAnimationView.loopAnimation = true
        headerAnimationView.play()
        headerAnimationView.isUserInteractionEnabled = true
        return headerAnimationView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playView: UIView = {
        let playView = UIView()
        playView.translatesAutoresizingMaskIntoConstraints = false
        return playView
    }()
    
    var podCast: Podcast!
    
    var isDownload = false
    var idToSearch = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setup() {
        
        backgroundColor = UIColor.primary
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        iconImageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        iconDownload.removeFromSuperview()
        iconDownloadAnimation.removeFromSuperview()
        
        addSubview(iconImageView)
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(iconDownload)
        iconDownload.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        iconDownload.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconDownload.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconDownload.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: iconDownload.leftAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        addSubview(playView)
        playView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playView.rightAnchor.constraint(equalTo: iconDownload.leftAnchor).isActive = true
        playView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tapGesture.numberOfTouchesRequired = 1
        iconDownload.addGestureRecognizer(tapGesture)
        
        let tapGestureView = UITapGestureRecognizer(target: self, action: #selector(tapHandlerView(_:)))
        tapGestureView.numberOfTouchesRequired = 1
        playView.addGestureRecognizer(tapGestureView)
        
        if SavedPodDAO.get().contains(where: { ($0.id == podCast.id && $0.download == true) } ) {
            self.iconDownload.image = #imageLiteral(resourceName: "cloudIcon").withRenderingMode(.alwaysTemplate)
            isDownload = true
        }
    }
    
    @objc func tapHandlerView(_ gesture: UIGestureRecognizer) {
        let playerViewController = PlayerViewController()
        playerViewController.id = podCast.id ?? ""
        let player = UINavigationController(rootViewController: playerViewController)
        AplicationUtil.getViewController()!.present(player, animated: true)
    }
    
    @objc func tapHandler(_ gesture: UIGestureRecognizer) {
        if isDownload {
            setup()
            isDownload = false
        }
        else {
            setupLoadView()
            isDownload = true
            let savedPod = SavedPodDAO.add(descriptionPod: self.podCast.description!,
                            icon: self.podCast.image!,
                            id: self.podCast.id!,
                            idPod: self.idToSearch,
                            title: self.podCast.title!,
                            url: "",
                            audio_length: self.podCast.audio_length!,
                            download: false)
            DownloadService.downloadPodCast(podCast: podCast) { result in
                if !result.isEmpty {
                    DispatchQueue.main.async {
                        self.iconDownload.image = #imageLiteral(resourceName: "cloudIcon").withRenderingMode(.alwaysTemplate)
                        SavedPodDAO.update(savedPod: savedPod)
                    }
                }
                DispatchQueue.main.async {
                    self.setup()
                }
            }
        }
    }
    
    func setupLoadView() {
        
        iconImageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        iconDownload.removeFromSuperview()
        iconDownloadAnimation.removeFromSuperview()
        
        addSubview(iconImageView)
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(iconDownloadAnimation)
        iconDownloadAnimation.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        iconDownloadAnimation.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconDownloadAnimation.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconDownloadAnimation.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: iconDownloadAnimation.leftAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        addSubview(playView)
        playView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playView.rightAnchor.constraint(equalTo: iconDownloadAnimation.leftAnchor).isActive = true
        playView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tapGesture.numberOfTouchesRequired = 1
        iconDownloadAnimation.addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

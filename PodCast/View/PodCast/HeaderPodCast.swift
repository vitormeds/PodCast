//
//  HeaderPodCast.swift
//  PodCast
//
//  Created by Vitor on 27/08/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

class HeaderPodCast: UIView {
    
    var podInfo: PodCastList!  {
        didSet{
            setupViews()
        }
    }
    
    let iconImageView: UIImageView = {
       let iconImageView = UIImageView()
       iconImageView.tintColor = UIColor.secondary
       iconImageView.image = #imageLiteral(resourceName: "headphone").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
       iconImageView.translatesAutoresizingMaskIntoConstraints = false
       return iconImageView
    }()
    
    let starImageView: UIImageView = {
        let starImageView = UIImageView()
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.tintColor = UIColor.secondary
        starImageView.image = #imageLiteral(resourceName: "starIconNotFilled").withRenderingMode(.alwaysTemplate)
        return starImageView
    }()
    
    let starLabel: UILabel = {
        let starLabel = UILabel()
        starLabel.textColor = UIColor.secondary
        starLabel.numberOfLines = 0
        starLabel.text = "Favoritar"
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        return starLabel
    }()
    
    let titlePodCast: UILabel = {
        let titlePodCast = UILabel()
        titlePodCast.textColor = UIColor.secondary
        titlePodCast.numberOfLines = 0
        titlePodCast.translatesAutoresizingMaskIntoConstraints = false
        return titlePodCast
    }()
    
    let mediaStackView: UIStackView = {
        let mediaStackView = UIStackView()
        mediaStackView.translatesAutoresizingMaskIntoConstraints = false
        mediaStackView.axis = NSLayoutConstraint.Axis.horizontal
        mediaStackView.distribution  = UIStackView.Distribution.fill
        mediaStackView.alignment = UIStackView.Alignment.fill
        mediaStackView.spacing = 16
        return mediaStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Identifier has not been implemeted")
    }
    
    func setupViews()
    {
        backgroundColor = UIColor.primary
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let urlImg: URL? = URL(string: podInfo.image ?? "")
        if urlImg != nil {
            let request2: ImageRequest? = ImageRequest(urlRequest: URLRequest(url: urlImg!))
            Nuke.loadImage(with: request2!, into: iconImageView)
        }
        
        titlePodCast.text = podInfo.title ?? ""
        
        addSubview(titlePodCast)
        titlePodCast.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titlePodCast.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        titlePodCast.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(mediaStackView)
        mediaStackView.topAnchor.constraint(equalTo: titlePodCast.bottomAnchor, constant: 8).isActive = true
        mediaStackView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        mediaStackView.heightAnchor.constraint(equalToConstant: 25)
        
        setupStackMedia()
        
        addSubview(starImageView)
        starImageView.topAnchor.constraint(equalTo: mediaStackView.bottomAnchor, constant: 8).isActive = true
        starImageView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(starLabel)
        starLabel.leftAnchor.constraint(equalTo: starImageView.rightAnchor, constant: 4).isActive = true
        starLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        starLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
    }
    
    func setupStackMedia()
    {
        if !(podInfo.extra?.facebook_handle?.isEmpty ?? false) {
            let iconMediaImageView = UIImageView()
            iconMediaImageView.translatesAutoresizingMaskIntoConstraints = false
            iconMediaImageView.tintColor = UIColor.secondary
            iconMediaImageView.image = #imageLiteral(resourceName: "iconfacebook").withRenderingMode(.alwaysTemplate)
            iconMediaImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            iconMediaImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            mediaStackView.addArrangedSubview(iconMediaImageView)
        }
        if !(podInfo.extra?.instagram_handle?.isEmpty ?? false) {
            let iconMediaImageView = UIImageView()
            iconMediaImageView.translatesAutoresizingMaskIntoConstraints = false
            iconMediaImageView.tintColor = UIColor.secondary
            iconMediaImageView.image = #imageLiteral(resourceName: "iconinstagram").withRenderingMode(.alwaysTemplate)
            iconMediaImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            iconMediaImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            mediaStackView.addArrangedSubview(iconMediaImageView)
        }
        if !(podInfo.extra?.twitter_handle?.isEmpty ?? false) {
            let iconMediaImageView = UIImageView()
            iconMediaImageView.translatesAutoresizingMaskIntoConstraints = false
            iconMediaImageView.tintColor = UIColor.secondary
            iconMediaImageView.image = #imageLiteral(resourceName: "icontwitter").withRenderingMode(.alwaysTemplate)
            iconMediaImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            iconMediaImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            mediaStackView.addArrangedSubview(iconMediaImageView)
        }
        if !(podInfo.extra?.youtube_url?.isEmpty ?? false) {
            let iconMediaImageView = UIImageView()
            iconMediaImageView.translatesAutoresizingMaskIntoConstraints = false
            iconMediaImageView.tintColor = UIColor.secondary
            iconMediaImageView.image = #imageLiteral(resourceName: "iconyoutube").withRenderingMode(.alwaysTemplate)
            iconMediaImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            iconMediaImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            mediaStackView.addArrangedSubview(iconMediaImageView)
        }
    }
    
}

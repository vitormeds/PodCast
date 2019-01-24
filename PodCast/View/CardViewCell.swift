//
//  CardViewCell.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class CardViewCell: UIView {
    
    var iconImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Mario")
        img.layer.zPosition = 2
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

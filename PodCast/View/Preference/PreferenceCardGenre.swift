//
//  PreferenceCardGenre.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class PreferenceCardGenre: UICollectionViewCell {
    
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.secondary
        imageView.image = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textColor = UIColor.secondary
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.zPosition = 2
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(checkImageView)
        checkImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        checkImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

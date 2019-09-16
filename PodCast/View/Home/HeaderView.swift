//
//  HeaderView.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

class HeaderView: UIView {
    
    let appLogo: LOTAnimationView = {
        let appLogo = LOTAnimationView(name: "loadAnimation")
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        appLogo.loopAnimation = true
        appLogo.play()
        return appLogo
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondary
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = R.string.localizable.appName()
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
        
        addSubview(appLogo)
        appLogo.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        appLogo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        appLogo.widthAnchor.constraint(equalToConstant: 30).isActive = true
        appLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: appLogo.rightAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}

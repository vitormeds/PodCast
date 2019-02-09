//
//  PreferenceHeaderView.swift
//  PodCast
//
//  Created by Vitor Mendes on 08/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class PreferenceHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.text = "Escolha alguns temas de seu interesse"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupViews()
    }
    
    func setupViews()
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 34
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
    }
    
}

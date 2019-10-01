//
//  RemoveAdTableViewCell.swift
//  PodCast
//
//  Created by Vitor on 01/10/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

protocol RemoveAdDelegate {
    func performRemoveAd()
}

class RemoveAdTableViewCell: UITableViewCell {
    
    var removeAdDelegate: RemoveAdDelegate!
    
    let removeAdButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.secondary.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle(R.string.localizable.removead(), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setup() {
        
        backgroundColor = UIColor.primary
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(removeAdButton)
        removeAdButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        removeAdButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        removeAdButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        removeAdButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        removeAdButton.addTarget(self, action: #selector(performClear), for: UIControl.Event.touchDown)
    }
    
    @objc func performClear() {
        removeAdDelegate.performRemoveAd()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SingleButtonTableViewCell.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

protocol ClearDataDelegate {
    func performClearData()
}

class SingleButtonTableViewCell: UITableViewCell {
    
    var clearDataDelegate: ClearDataDelegate!
    
    let clearDataButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.secondary.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle("Remover Dados", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setup() {
        
        backgroundColor = UIColor.primary
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        addSubview(clearDataButton)
        clearDataButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        clearDataButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        clearDataButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        clearDataButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        clearDataButton.addTarget(self, action: #selector(performClear), for: UIControl.Event.touchDown)
    }
    
    @objc func performClear() {
        clearDataDelegate.performClearData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

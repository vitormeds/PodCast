//
//  ConfigurationDescriptionCell.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class DescriptionConfigTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondary
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func setup() {
        
        backgroundColor = UIColor.primary
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

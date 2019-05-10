//
//  HeaderView.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

protocol HeaderCollectionDelegate {
    func showMore(genre: Genre)
}

class HeaderCollectionView: UIView {
    
    var delegate: HeaderCollectionDelegate!
    var genre: Genre!
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var moreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = R.string.localizable.mais()
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
        
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(moreLabel)
        moreLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        moreLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMore(sender:)))
        moreLabel.isUserInteractionEnabled = true
        moreLabel.addGestureRecognizer(tap)
    }
    
    @objc func showMore(sender: UITapGestureRecognizer? = nil) {
        delegate.showMore(genre: genre)
    }
    
}

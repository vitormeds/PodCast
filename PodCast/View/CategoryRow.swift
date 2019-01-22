//
//  File.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class CategoryRow : UITableViewCell {
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var card1 = CardViewCell()
    var card2 = CardViewCell()
    var card3 = CardViewCell()
    var card4 = CardViewCell()
    var card5 = CardViewCell()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews()
    {
        addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        scrollView.addSubview(card1)
        card1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        card1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollView.addSubview(card2)
        card2.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card2.leftAnchor.constraint(equalTo: card1.rightAnchor, constant: 16).isActive = true
        card2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollView.addSubview(card3)
        card3.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card3.leftAnchor.constraint(equalTo: card2.rightAnchor, constant: 16).isActive = true
        card3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollView.addSubview(card4)
        card4.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card4.leftAnchor.constraint(equalTo: card3.rightAnchor, constant: 16).isActive = true
        card4.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card4.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        scrollView.addSubview(card5)
        card5.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card5.leftAnchor.constraint(equalTo: card4.rightAnchor, constant: 16).isActive = true
        card5.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        card5.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card5.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

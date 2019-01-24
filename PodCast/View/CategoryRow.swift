//
//  File.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

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
        backgroundColor = UIColor.black
        addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        scrollView.addSubview(card1)
        card1.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        card1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let request1 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/21db45ed585e43a0bdc8e7900ee5af3d.jpg")!))
        Nuke.loadImage(with: request1, into: card1.iconImageView)
        card1.titleLabel.text = "LOCKED ON NBA -- 10/26/18 -- LeBron James, Lakers beat Nuggets, Thunder continue to disappoint"
        card1.nameLabel.text = "Name"
        
        scrollView.addSubview(card2)
        card2.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card2.leftAnchor.constraint(equalTo: card1.rightAnchor, constant: 16).isActive = true
        card2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/f7f881dffcec49caaa63cf580c9afbbb.jpg")!))
        Nuke.loadImage(with: request2, into: card2.iconImageView)
        card2.titleLabel.text = "HBO's The Shop via LeBron James, Durant's Discredit, Jealous Kawhi and More"
        card2.nameLabel.text = "Name"
        
        scrollView.addSubview(card3)
        card3.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card3.leftAnchor.constraint(equalTo: card2.rightAnchor, constant: 16).isActive = true
        card3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let request3 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/36420d87f75540279e7c33ea9ee7eb81.jpg")!))
        Nuke.loadImage(with: request3, into: card3.iconImageView)
        card3.titleLabel.text = "Zach Lowe on I'm Interested"
        card3.nameLabel.text = "Name"
        
        scrollView.addSubview(card4)
        card4.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card4.leftAnchor.constraint(equalTo: card3.rightAnchor, constant: 16).isActive = true
        card4.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card4.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let request4 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/b9b73d0d4dca427783e226f7e6ec9e1f.jpg")!))
        Nuke.loadImage(with: request4, into: card4.iconImageView)
        card4.titleLabel.text = "Jay Glazer + Should Lebron James Go To Jail?"
        card4.nameLabel.text = "Name"
        
        scrollView.addSubview(card5)
        card5.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        card5.leftAnchor.constraint(equalTo: card4.rightAnchor, constant: 16).isActive = true
        card5.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        card5.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        card5.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let request5 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/e72bed802fd5422eb4fb653d9878cf2c.jpg")!))
        Nuke.loadImage(with: request5, into: card5.iconImageView)
        card5.titleLabel.text = "Full Show (Cowboys upset?, Baker Mayfield, LeBron James, Tim Tebow)"
        card5.nameLabel.text = "Name"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

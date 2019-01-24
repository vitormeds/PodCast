//
//  CollectionCell.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

class CollectionCell : UITableViewCell {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 170)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews()
    {
        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: "https://d3sv2eduhewoas.cloudfront.net/channel/image/f7f881dffcec49caaa63cf580c9afbbb.jpg")!))
        Nuke.loadImage(with: request2, into: cell.iconImageView)
        cell.titleLabel.text = "HBO's The Shop via LeBron James, Durant's Discredit, Jealous Kawhi and More"
        cell.nameLabel.text = "Name"
        return cell
    }
    
}

extension CollectionCell: UICollectionViewDelegate {
    
}

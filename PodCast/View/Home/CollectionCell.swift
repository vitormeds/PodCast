//
//  CollectionCell.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

protocol SelectBestPodDelegate {
    func selectPod(id: String?, bestPod: BestPod?)
}

class CollectionCell : UITableViewCell {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    
    var delegate: SelectBestPodDelegate!
    
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
    
    
    var  bestPods: [BestPod]!  {
        didSet{
            setupViews()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CollectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestPods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let urlImg: URL? = URL(string: bestPods[indexPath.item].image ?? "")
        if urlImg != nil {
            let request2: ImageRequest? = ImageRequest(urlRequest: URLRequest(url: urlImg!))
            Nuke.loadImage(with: request2!, into: cell.iconImageView)
        }
        cell.titleLabel.text = bestPods[indexPath.item].title
        cell.nameLabel.text = bestPods[indexPath.item].publisher
        return cell
    }
    
}

extension CollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.selectPod(id: bestPods[indexPath.item].id ?? "", bestPod: bestPods[indexPath.item])
    }
}

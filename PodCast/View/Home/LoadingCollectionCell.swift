//
//  LoadingCollectionCell.swift
//  PodCast
//
//  Created by Vitor Mendes on 19/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class LoadingCollectionCell: UICollectionReusableView {
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
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
        addSubview(refresher)
        refresher.topAnchor.constraint(equalTo: topAnchor).isActive = true
        refresher.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        refresher.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

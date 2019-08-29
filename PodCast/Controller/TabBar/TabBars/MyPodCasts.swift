//
//  MyPodCasts.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

class MyPodCasts: CustomViewController {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    
    var myPods: MyPods? = nil
    
    var headerView = HeaderView()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 170)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        myPods = MyPodsDataController.getMyPods()
        collectionView.reloadData()
    }
    
    func setupViews()
    {
        headerView.titleLabel.text = "Inscrições"
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
}

extension MyPodCasts: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPods?.id?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: (myPods?.icon![indexPath.item])!)!))
        Nuke.loadImage(with: request2, into: cell.iconImageView)
        cell.titleLabel.text = myPods?.title![indexPath.item]
        return cell
    }
    
}

extension MyPodCasts: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = PodCastListViewController()
        playerViewController.podCastSearch = PodCastSearch(lastest_pub_date_ms: nil,
           description_highlighted: nil,
           itunes_id: nil,
           publisher_original: nil,
           earliest_pub_date_ms: nil,
           genres: nil,
           description_original: nil,
           title_highlighted: nil,
           email: nil, rss: nil,
           thumbnail: myPods?.icon?[indexPath.item] ?? "",
           title_original: myPods?.title?[indexPath.item] ?? "",
           image: myPods?.icon?[indexPath.item] ?? "",
           explicit_content: nil,
           id: myPods?.id?[indexPath.item] ?? "",
           total_episodes: nil,
           listennotes_url: nil,
           publisher_highlighted: nil)
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
}


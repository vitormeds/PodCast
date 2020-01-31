//
//  MyPodCasts.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke
import GoogleMobileAds

class MyPodCasts: CustomViewController {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    
    var myPods: [MyPods]? = nil
    
    var headerView = HeaderView()
    
    var bannerView: GADBannerView!
    
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
        view.backgroundColor = UIColor.primary
        setupAd()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        myPods = MyPodsDAO.get()
        collectionView.reloadData()
    }
    
    func setupViews()
    {
        headerView.titleLabel.text = R.string.localizable.inscricoes()
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        if Ad.isPremium {
             collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            collectionView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        }
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    func setupAd() {
        
        if Ad.isPremium {
            return
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Ad.adBannerMyPods
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bannerView)
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bannerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    func reloadAd() {
        if IAProducts.store.isProductPurchased(IAProducts.premium) {
            Ad.isPremium = true
            
        }
    }
}

extension MyPodCasts: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: (myPods![indexPath.item].icon!))!))
        Nuke.loadImage(with: request2, into: cell.iconImageView)
        cell.titleLabel.text = myPods![indexPath.item].title
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
           thumbnail: myPods?[indexPath.item].icon ?? "",
           title_original: myPods?[indexPath.item].title ?? "",
           image: myPods?[indexPath.item].icon ?? "",
           explicit_content: nil,
           id: myPods?[indexPath.item].id ?? "",
           total_episodes: nil,
           listennotes_url: nil,
           publisher_highlighted: nil)
        let player = UINavigationController(rootViewController: playerViewController)
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
}

extension MyPodCasts: GADBannerViewDelegate{
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }
}

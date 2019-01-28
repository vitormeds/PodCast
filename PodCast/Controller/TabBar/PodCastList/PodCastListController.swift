//
//  PodCastListController.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

class PodCastListViewController: CustomViewController {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    
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
    
    var  bestPod: BestPod!  {
        didSet{
            title = bestPod.title
            loadData()
        }
    }
    
    var pods = [Podcast]()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .done, target: self, action: #selector(performBack))
    }
    
    func loadData()
    {
        startLoad()
        PodCastListService.getPodCastListById(id: bestPod.id ?? "") { podCastsResult in
            if podCastsResult != nil {
                self.pods = podCastsResult?.episodes ?? []
                self.stopLoad()
                self.setupViews()
            }
        }
    }
    
    func setupViews()
    {
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCellIdentifier)
        collectionView.reloadData()
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
}

extension PodCastListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: pods[indexPath.item].thumbnail ?? pods[indexPath.item].image ?? "")!))
        Nuke.loadImage(with: request2, into: cell.iconImageView)
        cell.titleLabel.text = pods[indexPath.item].title
        return cell
    }
    
}

extension PodCastListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = PlayerViewController()
        playerViewController.id = pods[indexPath.section].id ?? ""
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
}


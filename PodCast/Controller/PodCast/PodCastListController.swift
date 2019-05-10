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
    
    var bestPod: BestPod!  {
        didSet{
            title = bestPod.title
            loadData()
        }
    }
    
    var podCastSearch: PodCastSearch!  {
        didSet{
            title = podCastSearch.title_original ?? ""
            loadData()
        }
    }
    
    var isLoading = false
    
    var pods = [Podcast]()
    var podInfo: PodCastList!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
    }
    
    func loadData()
    {
        if pods.isEmpty {
            startLoad()
        }
        var idToSearch = ""
        if bestPod != nil {
            idToSearch = bestPod.id!
        }
        else {
            idToSearch = podCastSearch.id!
        }
        if isLoading == false {
            isLoading = true
            var next = ""
            if podInfo != nil && podInfo.next_episode_pub_date != nil {
                next = (podInfo.next_episode_pub_date?.description)!
            }
            if podInfo == nil || podInfo.total_episodes! > pods.count {
                PodCastListService.getPodCastListById(id: idToSearch,next: next) { podCastsResult in
                    if podCastsResult != nil {
                        if self.pods.isEmpty {
                            self.pods = podCastsResult?.episodes ?? []
                        }
                        else {
                            for element in podCastsResult?.episodes ?? [] {
                                self.pods.append(element)
                            }
                        }
                        self.podInfo = podCastsResult
                        self.stopLoad()
                        self.setupViews()
                    }
                    self.isLoading = false
                }
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
        playerViewController.id = pods[indexPath.item].id ?? ""
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pods.count - 1 {
            loadData()
        }
    }
}


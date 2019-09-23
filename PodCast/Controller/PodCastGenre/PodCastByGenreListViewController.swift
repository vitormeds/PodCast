//
//  PodCastByGenreListViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 10/05/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke

class PodCastByGenreListViewController: CustomViewController {
    
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
    
    var genre: Genre!  {
        didSet{
            title = genre.name
            loadData()
        }
    }
    
    var bestPods = [BestPod]()
    var bestPodElement : BestPodElement!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        setupViews()
    }
    
    func loadData() {
        if bestPodElement != nil && !(bestPodElement?.has_next ?? false) {
            return
        }
        if bestPods.count < 0 {
            startLoad()
        }
        PodCastListService.getBestPodsByGenre(genre: genre,page: bestPodElement?.next_page_number?.description ?? "1", completionHandler: { resultBestPods in
            if resultBestPods != nil {
                self.bestPodElement = resultBestPods
                if self.bestPods.isEmpty {
                    self.bestPods = resultBestPods?.channels ?? []
                }
                else {
                    for element in resultBestPods?.channels ?? [] {
                        self.bestPods.append(element)
                    }
                }
            }
            if self.bestPods.count < 0 {
                self.stopLoad()
            }
            self.collectionView.reloadData()
        })
    }
    
    func setupViews()
    {
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
}

extension PodCastByGenreListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestPods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let urlImg: URL? = URL(string: bestPods[indexPath.item].thumbnail ?? bestPods[indexPath.item].image ?? "")
        if urlImg != nil {
            let request2: ImageRequest? = ImageRequest(urlRequest: URLRequest(url: urlImg!))
            Nuke.loadImage(with: request2!, into: cell.iconImageView)
        }
        cell.titleLabel.text = bestPods[indexPath.item].title
        return cell
    }
    
}

extension PodCastByGenreListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = PodCastListViewController()
        playerViewController.bestPod = bestPods[indexPath.item]
        let player = UINavigationController(rootViewController: playerViewController)
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == bestPods.count - 1 {
            loadData()
        }
    }
}


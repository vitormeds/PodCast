//
//  PreferencesSelectController.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

fileprivate let cardReuseIdentifier = "CardCell"
fileprivate let headerId = "CollectionReusableView"

class PreferencesSelectController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var genres = [Genre]()
    var selectedGenres = [Int]()
    var colors = [UIColor]()
    
    let lottieLoading: LOTAnimationView = {
        let headerAnimationView = LOTAnimationView(name: "loadAnimation")
        headerAnimationView.translatesAutoresizingMaskIntoConstraints = false
        headerAnimationView.loopAnimation = true
        headerAnimationView.play()
        return headerAnimationView
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 150, height: 170)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.primary
        navigationController?.navigationBar.tintColor = UIColor.secondary
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.secondary]
        title = R.string.localizable.assuntos()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.iniciar(), style: .done, target: self, action: #selector(performNext))
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.primary
        view.backgroundColor = UIColor.primary
        collectionView.register(PreferenceCardGenre.self, forCellWithReuseIdentifier: cardReuseIdentifier)
        collectionView.register(PreferenceHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")

        loadData()
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func startLoad() {
        view.addSubview(lottieLoading)
        lottieLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lottieLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lottieLoading.heightAnchor.constraint(equalToConstant: 100).isActive = true
        lottieLoading.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func stopLoad() {
        lottieLoading.removeFromSuperview()
    }
    
    func loadData() {
        startLoad()
        PodCastListService.getGenres { genresResult in
            if genresResult != nil {
                self.genres = genresResult!
                for element in self.genres {
                    self.colors.append(UIColor.random)
                }
                self.stopLoad()
                self.setupViews()
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath) as! PreferenceHeaderView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 20
        var width = (collectionView.frame.size.width / 2) - CGFloat(paddingSpace)
        if width > 187.5 {
            let qtdNecessario = (collectionView.frame.size.width / 187.5).rounded(.down)
            let newWidth = (collectionView.frame.size.width / qtdNecessario) - 20
            width = newWidth
        }
        let height = CGFloat(60)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardReuseIdentifier, for: indexPath) as! PreferenceCardGenre
        cell.backgroundColor = #colorLiteral(red: 0.2519568801, green: 0.2802801728, blue: 0.3001171947, alpha: 1)
        cell.titleLabel.text = genres[indexPath.item].name
        if selectedGenres.contains(indexPath.item) {
            cell.checkImageView.isHidden = false
        }
        else {
            cell.checkImageView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !selectedGenres.contains(indexPath.item) {
            selectedGenres.append(indexPath.item)
        }
        else {
            var elementToDelete = 0
            for i in 0...selectedGenres.count - 1 {
                if genres[indexPath.item].id == genres[selectedGenres[i]].id {
                    elementToDelete = i
                }
            }
            selectedGenres.remove(at: elementToDelete)
        }
        colors[indexPath.item] = UIColor.random
        collectionView.reloadItems(at: [indexPath])
    }
    
    @objc func performNext() {
        var selectedGenresOptions = [Genre]()
        if selectedGenres.count != 0 {
            for i in 0...selectedGenres.count - 1 {
                selectedGenresOptions.append(genres[selectedGenres[i]])
            }
        }
        PreferencesDAO.add(genres: selectedGenresOptions)
        let standard = UserDefaults.standard
        standard.set(true, forKey: "preferencesInicialize")
        present(CustomTabBarController(), animated: true)
    }
}

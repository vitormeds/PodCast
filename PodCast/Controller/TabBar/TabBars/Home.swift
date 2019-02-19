//
//  Home.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie
import Nuke

class Home: CustomViewController,UITableViewDelegate,UITableViewDataSource {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    let contentCardCellIdentifier = "contentCardCellIdentifier"
    
    var searchMode = false
    var searchLayout = false
    
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
    
    var searchPods = [PodCastSearch]()
    
    var  bestPod: BestPod!  {
        didSet{
            title = bestPod.title
            loadData()
        }
    }
    
    var pods = [Podcast]()
    
    var genres = [Genre]()
    var bestPods = [[BestPod]]()
    var list = 10
    
    var isSearch = false
    let searchBarView = UIView()
    lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = R.string.localizable.buscar()
        searchBar.cancelTitle = R.string.localizable.fechar()
        searchBar.showsCancelButton = false
        searchBar.barTintColor = UIColor.black
        searchBar.tintColor = UIColor.black
        searchBar.backgroundColor = UIColor.black
        searchBar.delegate = self
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.cancelButtonColor = UIColor.white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if searchMode == false && PlayerController.player != nil && PlayerController.player?.rate != 0 {
            setupDefaultMode()
        }
        else if searchMode == true && PlayerController.player != nil && PlayerController.player?.rate != 0{
            setupSearchMode()
        }
    }
    
    func setupDefaultMode() {
        searchBar.removeFromSuperview()
        tableView.removeFromSuperview()
        audioPlayerBar.removeFromSuperview()
        collectionView.removeFromSuperview()
        if PlayerController.player != nil && PlayerController.player?.rate != 0
        {
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            audioPlayerBar = PlayerController.audioPlayerBar
            view.addSubview(audioPlayerBar)
            audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            audioPlayerBar.closeButton.addTarget(self, action: #selector(closePlayer), for: .touchDown)
            
            view.addSubview(tableView)
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
        }
        else  {
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            view.addSubview(tableView)
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        searchLayout = false
    }
    
    func setupSearchMode() {
        searchBar.removeFromSuperview()
        tableView.removeFromSuperview()
        audioPlayerBar.removeFromSuperview()
        collectionView.removeFromSuperview()
        if PlayerController.player != nil && PlayerController.player?.rate != 0
        {
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            audioPlayerBar = PlayerController.audioPlayerBar
            view.addSubview(audioPlayerBar)
            audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            audioPlayerBar.closeButton.addTarget(self, action: #selector(closePlayerBar), for: .touchDown)
            
            view.addSubview(collectionView)
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
        }
        else  {
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            view.addSubview(collectionView)
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        searchLayout = true
    }
    
    @objc func closePlayer() {
        PlayerController.player?.pause()
        if searchMode {
            setupSearchMode()
        }
        else {
            setupDefaultMode()
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCardCellIdentifier)
        loadData()
    }
    
    func loadData() {
        startLoad()
        let preferences = PreferencesDataController.getPreferences()
        var result = [Genre]()
        if preferences != nil && preferences?.id != nil && !(preferences?.id?.isEmpty)! {
            for i in 0...preferences!.id!.count - 1 {
                result.append(Genre(parent_id: preferences?.parent_id![i],name: preferences?.name![i],id: preferences?.id![i]))
            }
            self.genres = result
            PodCastListService.getBestPodsByGenre(genres: self.genres, completionHandler: { resultBestPods in
                if resultBestPods != nil {
                    self.bestPods = resultBestPods!
                }
                self.setupDefaultMode()
                self.stopLoad()
                self.tableView.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CollectionCell
        cell.bestPods = bestPods[indexPath.section]
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headeView = HeaderView()
        headeView.titleLabel.text = genres[section].name
        return headeView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bestPods.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension Home: SelectBestPodDelegate {
    
    func selectPod(id: String?, bestPod: BestPod?) {
        let playerViewController = PodCastListViewController()
        playerViewController.bestPod = bestPod
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
}

extension Home: UISearchBarDelegate,UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !isSearch {
            isSearch = !isSearch
            SearchService.searchPodCast(search: searchBar.text ?? "") { result in
                self.isSearch = false
                if result != nil && !(result?.isEmpty)! {
                    self.searchPods = result!
                    if self.collectionView.isHidden {
                        self.collectionView.isHidden = false
                        self.stopLoad()
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchMode = true
        if self.searchLayout == false {
            self.setupSearchMode()
        }
        if searchPods == nil || searchPods.isEmpty {
            collectionView.isHidden = true
            startLoad()
        }
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchMode = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchPods.removeAll()
        setupDefaultMode()
    }
}

extension Home {
    
    @objc func myRefeshMethod() {
        
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
}

extension Home: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCardCellIdentifier, for: indexPath) as! ContentCollectionViewCell
        let request2 = ImageRequest(urlRequest: URLRequest(url: URL(string: searchPods[indexPath.item].thumbnail ?? searchPods[indexPath.item].image ?? "")!))
        Nuke.loadImage(with: request2, into: cell.iconImageView)
        cell.titleLabel.text = searchPods[indexPath.item].title_original
        return cell
    }
    
}

extension Home: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = PlayerViewController()
        playerViewController.id = searchPods[indexPath.item].id ?? ""
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
}


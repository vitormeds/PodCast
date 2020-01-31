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
import GoogleMobileAds

class Home: CustomViewController,UITableViewDelegate,UITableViewDataSource {
    
    let contentCellIdentifier = "ContentCellIdentifier"
    let contentCardCellIdentifier = "contentCardCellIdentifier"
    let cartFooterCollectionReusableView = "CartFooterCollectionReusableView"
    
    public enum SearchCategory {
        case episodes
        case podcasts
    }
    
    var searchMode = false
    var searchLayout = false
    var searchType: SearchCategory = SearchCategory.episodes
    
    var headerView = HeaderView()
    
    var bannerView: GADBannerView!
    var failAd = false
    
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
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: [R.string.localizable.episodio(),R.string.localizable.podcast()])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(changeSearchType), for: .valueChanged)
        segmentControl.backgroundColor = UIColor.primary
        segmentControl.tintColor = UIColor.secondary
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    var searchEpisodes: EpisodeSearchList!
    var searchPodCasts: PodCastSearchList!
    var searchEpisodesData = [EpisodeSearch]()
    var searchPodCastsData = [PodCastSearch]()
    
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
        searchBar.barTintColor = UIColor.primary
        searchBar.tintColor = UIColor.primary
        searchBar.backgroundColor = UIColor.primary
        searchBar.delegate = self
        searchBar.layer.borderColor = UIColor.primary.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.cancelButtonColor = UIColor.secondary
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Ad.adBannerHome
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        bannerView.translatesAutoresizingMaskIntoConstraints = false
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
        segmentControl.removeFromSuperview()
        headerView.removeFromSuperview()
        bannerView.removeFromSuperview()
        if PlayerController.player != nil && PlayerController.player?.rate != 0
        {
            view.addSubview(headerView)
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            if (!failAd && !Ad.isPremium) {
                view.addSubview(bannerView)
                bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                bannerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            }
            
            audioPlayerBar = PlayerController.audioPlayerBar
            view.addSubview(audioPlayerBar)
            if (!failAd && !Ad.isPremium) {
                audioPlayerBar.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
            }
            else {
                audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            }
            audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            audioPlayerBar.closeButton.addTarget(self, action: #selector(closePlayer), for: .touchDown)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(showPlayer(sender:)))
            audioPlayerBar.isUserInteractionEnabled = true
            audioPlayerBar.addGestureRecognizer(tap)
            
            view.addSubview(tableView)
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
        }
        else  {
            view.addSubview(headerView)
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            if (!failAd && !Ad.isPremium) {
                view.addSubview(bannerView)
                bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                bannerView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            }
            
            view.addSubview(tableView)
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            if (!failAd && !Ad.isPremium) {
                tableView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
            }
            else {
                tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            }
        }
        searchLayout = false
    }
    
    func setupSearchMode() {
        searchBar.removeFromSuperview()
        tableView.removeFromSuperview()
        audioPlayerBar.removeFromSuperview()
        collectionView.removeFromSuperview()
        segmentControl.removeFromSuperview()
        headerView.removeFromSuperview()
        if PlayerController.player != nil && PlayerController.player?.rate != 0
        {
            view.addSubview(headerView)
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            view.addSubview(segmentControl)
            segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            audioPlayerBar = PlayerController.audioPlayerBar
            view.addSubview(audioPlayerBar)
            audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            audioPlayerBar.closeButton.addTarget(self, action: #selector(closePlayer), for: .touchDown)
            
            view.addSubview(collectionView)
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 16).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
        }
        else  {
            view.addSubview(headerView)
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            view.addSubview(searchBar)
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
            tableView.tableHeaderView = searchBarView
            
            view.addSubview(segmentControl)
            segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            
            view.addSubview(collectionView)
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 16).isActive = true
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
        view.backgroundColor = UIColor.primary
        tableView.delegate = self
        tableView.dataSource = self
        //UIApplication.shared.statusBarView?.backgroundColor = UIColor.secondary
        collectionView.register(ContentCollectionViewCell.self,forCellWithReuseIdentifier: contentCardCellIdentifier)
        collectionView.register(LoadingCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cartFooterCollectionReusableView)
        loadData()
        SharedDownload.downloadService.verifyQueue()
    }
    
    func loadData() {
        startLoad()
        let preferences = PreferencesDAO.get()
        var result = [Genre]()
        if preferences != nil {
            for i in 0...preferences.count - 1 {
                let a = preferences[i].parent_id
                result.append(Genre(parent_id: Int(preferences[i].parent_id!),name: preferences[i].name,id: Int(preferences[i].id!)))
            }
            self.genres = result
            let region = NSLocale.current.regionCode?.lowercased()
            let standard = UserDefaults.standard
            if !standard.bool(forKey: "locationPreference") {
                CountryService.getCountries { countries in
                    let countriesAux = countries?.filter({ ($0.key?.lowercased() == region)}) ?? []
                    if !countriesAux.isEmpty {
                        UserInfoDAO.add(location: countriesAux.first?.key, locationdescription: countriesAux.first?.value)
                        standard.set(true, forKey: "locationPreference")
                    }
                    self.loadPods()
                }
            }
            else {
                loadPods()
            }
        }
    }
    
    func loadPods() {
        PodCastListService.getBestPodsByGenre(genres: self.genres, completionHandler: { resultBestPods in
            if resultBestPods != nil {
                for element in resultBestPods ?? [] {
                    if !element.isEmpty {
                        self.bestPods.append(element)
                    }
                }
            }
            self.setupDefaultMode()
            self.stopLoad()
            self.tableView.reloadData()
        })
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
        let headeView = HeaderCollectionView()
        headeView.delegate = self
        headeView.genre = genres[section]
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
    
    func reloadAd() {
        if IAProducts.store.isProductPurchased(IAProducts.premium) {
            Ad.isPremium = true
            headerView.titleLabel.text = R.string.localizable.appName() + (Ad.isPremium ? " Premium":"")
            for element in bannerView.constraints {
                if element.constant == 50 {
                    element.constant = 0
                }
            }
        }
    }
}

extension Home: SelectBestPodDelegate {
    
    func selectPod(id: String?, bestPod: BestPod?) {
        let playerViewController = PodCastListViewController()
        playerViewController.bestPod = bestPod
        let player = UINavigationController(rootViewController: playerViewController)
        player.modalPresentationStyle = .overFullScreen
        present(player, animated: true)
    }
}

extension Home: UISearchBarDelegate,UISearchResultsUpdating {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (searchType == SearchCategory.episodes && (indexPath.row == searchEpisodesData.count - 1)) || (searchType == SearchCategory.podcasts && (indexPath.row == searchPodCastsData.count - 1))  {
            if (searchType == SearchCategory.podcasts && (searchPodCasts.next_offset != searchPodCasts.total)) ||
                (searchType == SearchCategory.episodes && (searchEpisodes.next_offset != searchEpisodes.total)) {
                loadSearchData(isUpdate: true)
            }
        }
    }
    
    @objc func changeSearchType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchType = SearchCategory.episodes
        case 1:
            searchType = SearchCategory.podcasts
        default:
            searchType = SearchCategory.episodes
        }
        if (searchType == SearchCategory.episodes && searchEpisodesData.isEmpty) || (searchType == SearchCategory.podcasts && searchPodCastsData.isEmpty)
        {
            loadSearchData()
            collectionView.reloadData()
        }
        else {
            collectionView.reloadData()
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionView.ScrollPosition.top, animated: false)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        loadSearchData()
        return true
    }
    
    func loadSearchData(isUpdate: Bool? = false) {
        if !isSearch {
            isSearch = !isSearch
            if searchType == SearchCategory.episodes
            {
                if !isUpdate! {
                    SearchService.searchEpisodePodCast(search: searchBar.text ?? "") { result in
                        self.isSearch = false
                        if result != nil && !(result?.results?.isEmpty)! {
                            self.searchEpisodes = result
                            self.searchEpisodesData = (result?.results)!
                            if self.collectionView.isHidden {
                                self.collectionView.isHidden = false
                                self.stopLoad()
                            }
                            self.collectionView.reloadData()
                        }
                    }
                }
                else {
                    if searchEpisodes == nil || (searchEpisodes.next_offset == searchEpisodes.total) == false {
                        var next = ""
                        if searchEpisodes != nil {
                            next = (searchEpisodes.next_offset?.description)!
                        }
                        SearchService.searchEpisodePodCast(search: searchBar.text ?? "", next: next) { result in
                            self.isSearch = false
                            if result != nil && !(result?.results?.isEmpty)! {
                                if self.searchEpisodes == nil || (self.searchEpisodesData.isEmpty) {
                                    self.searchEpisodes = result
                                    self.searchEpisodesData = (result?.results)!
                                }
                                else {
                                    self.searchEpisodes = result
                                    for element in (result?.results)! {
                                        self.searchEpisodesData.append(element)
                                    }
                                }
                                if self.collectionView.isHidden {
                                    self.collectionView.isHidden = false
                                    self.stopLoad()
                                }
                                self.collectionView.reloadData()
                            }
                        }
                    }
                    else {
                        self.isSearch = false
                    }
                }
            }
            else {
                if !isUpdate! {
                    SearchService.searchPodCast(search: searchBar.text ?? "") { result in
                        self.isSearch = false
                        if result != nil && !(result?.results?.isEmpty)! {
                            self.searchPodCasts = result
                            self.searchPodCastsData = (result?.results)!
                            if self.collectionView.isHidden {
                                self.collectionView.isHidden = false
                                self.stopLoad()
                            }
                            self.collectionView.reloadData()
                        }
                    }
                }
                else {
                    if searchPodCasts == nil || (searchPodCasts.next_offset == searchPodCasts.total) == false {
                        var next = ""
                        if searchPodCasts != nil {
                            next = (searchPodCasts.next_offset?.description)!
                        }
                        SearchService.searchPodCast(search: searchBar.text ?? "", next: next) { result in
                            self.isSearch = false
                            if result != nil && !(result?.results?.isEmpty)! {
                                if self.searchPodCasts == nil || (self.searchPodCastsData.isEmpty) {
                                    self.searchPodCasts = result
                                    self.searchPodCastsData = (result?.results)!
                                }
                                else {
                                    self.searchPodCasts = result
                                    for element in (result?.results)! {
                                        self.searchPodCastsData.append(element)
                                    }
                                }
                                if self.collectionView.isHidden {
                                    self.collectionView.isHidden = false
                                    self.stopLoad()
                                }
                                self.collectionView.reloadData()
                            }
                        }
                    }
                    else {
                        self.isSearch = false
                    }
                }
            }
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchMode = true
        if self.searchLayout == false {
            self.setupSearchMode()
        }
        if (searchType == SearchCategory.episodes && (searchEpisodes == nil || searchEpisodesData.isEmpty)) || (searchType == SearchCategory.podcasts && (searchPodCasts == nil || searchPodCastsData.isEmpty)) {
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
        searchEpisodes = nil
        searchPodCasts = nil
        searchPodCastsData.removeAll()
        searchEpisodesData.removeAll()
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
        if searchType == SearchCategory.episodes
        {
            if searchEpisodes == nil {
                return 0
            }
            else {
                return searchEpisodesData.count
            }
        }
        else {
            if searchPodCasts == nil {
                return 0
            }
            else {
                return searchPodCastsData.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (searchType == SearchCategory.podcasts && (searchPodCastsData.count <= indexPath.item)) || (searchType == SearchCategory.episodes && (searchEpisodesData.count <= indexPath.item)) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! UICollectionViewCell
        }
        else if searchType == SearchCategory.episodes
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCardCellIdentifier, for: indexPath) as! ContentCollectionViewCell
            let urlImg: URL? = URL(string: searchEpisodesData[indexPath.item].thumbnail ?? searchEpisodesData[indexPath.item].image ?? "")
            if urlImg != nil {
                let request2 = ImageRequest(urlRequest: URLRequest(url: urlImg!))
                Nuke.loadImage(with: request2, into: cell.iconImageView)
            }
            cell.titleLabel.text = searchEpisodesData[indexPath.item].title_original
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCardCellIdentifier, for: indexPath) as! ContentCollectionViewCell
            let urlImg: URL? = URL(string: searchPodCastsData[indexPath.item].thumbnail ?? searchPodCastsData[indexPath.item].image ?? "")
            if urlImg != nil {
                let request2 = ImageRequest(urlRequest: URLRequest(url: urlImg!))
                Nuke.loadImage(with: request2, into: cell.iconImageView)
            }
            cell.titleLabel.text = searchPodCastsData[indexPath.item].title_original
            return cell
        }
    }
    
}

extension Home: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchType == SearchCategory.episodes {
            let playerViewController = PlayerViewController()
            playerViewController.id = searchEpisodesData[indexPath.item].id ?? ""
            let player = UINavigationController(rootViewController: playerViewController)
            player.modalPresentationStyle = .overFullScreen
            present(player, animated: true)
        }
        else {
            let playerViewController = PodCastListViewController()
            playerViewController.podCastSearch = searchPodCastsData[indexPath.item]
            let player = UINavigationController(rootViewController: playerViewController)
            player.modalPresentationStyle = .overFullScreen
            present(player, animated: true)
        }
    }
}

extension Home: HeaderCollectionDelegate {
    
    func showMore(genre: Genre) {
        let podCastByGenreListViewController = PodCastByGenreListViewController()
        podCastByGenreListViewController.genre = genre
        let podCastByGenreList = UINavigationController(rootViewController: podCastByGenreListViewController)
        podCastByGenreList.modalPresentationStyle = .overFullScreen
        present(podCastByGenreList, animated: true)
    }
}

extension Home: GADBannerViewDelegate{
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        failAd = true
    }
}

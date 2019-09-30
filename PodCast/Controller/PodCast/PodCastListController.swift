//
//  PodCastListController.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Nuke
import GoogleMobileAds

class PodCastListViewController: CustomViewController {
    
    var myPods: [MyPods]? = nil
    
    var idToSearch = ""
    
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
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        SharedDownload.downloadService.downloadManagerDelegate = self
    }
    
    func starLoad() {
        myPods = MyPodsDAO.get()
        var myPodsIcon =  #imageLiteral(resourceName: "starIconNotFilled").withRenderingMode(.alwaysTemplate)
        if myPods != nil && podInfo != nil && !(myPods?.isEmpty ?? false) && myPods?.contains(where: { ($0.id == podInfo.id ?? "")}) ?? false {
            myPodsIcon = #imageLiteral(resourceName: "starIconFilled").withRenderingMode(.alwaysTemplate)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myPodsIcon, style: UIBarButtonItem.Style.done, target: self, action: #selector(performStar))
    }
    
    func loadData()
    {
        if pods.isEmpty {
            startLoad()
        }
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
                        self.setupAd()
                        self.setupViews()
                        self.starLoad()
                    }
                    else {
                        if self.pods.isEmpty {
                            for element in SavedPodDAO.get().filter({ ($0.idPod == self.idToSearch && $0.download == true) }) {
                                self.pods.append(Podcast(audio_length: nil,
                                                         image: element.icon,
                                                         title: element.title,
                                                         listennotes_edit_url: nil,
                                                         explicit_content: nil,
                                                         audio: nil,
                                                         pub_date_ms: nil,
                                                         podcast: nil,
                                                         description: element.descriptionPod,
                                                         id: element.id,
                                                         thumbnail: element.icon,
                                                         listennotes_url: nil,
                                                         maybe_audio_invalid: nil,
                                                         isDownload: true))
                            }
                            self.stopLoad()
                            self.setupAd()
                            self.setupViews()
                            let myPodsIcon = #imageLiteral(resourceName: "starIconFilled").withRenderingMode(.alwaysTemplate)
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myPodsIcon, style: UIBarButtonItem.Style.done, target: self, action: #selector(self.performStar))
                        }
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    func setupViews()
    {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        tableView.reloadData()
    }
    
    func setupAd() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = Ad.adBannerListPods
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
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
    
    @objc func performStar() {
        let idPod = bestPod?.id ?? podCastSearch?.id ?? ""
        let iconPod = bestPod?.image ?? podCastSearch?.thumbnail ?? ""
        let titlePod = bestPod?.title ?? bestPod?.image ?? podCastSearch?.title_original ?? ""
        myPods = MyPodsDAO.get()
        var myPodsIcon =  #imageLiteral(resourceName: "starIconFilled").withRenderingMode(.alwaysTemplate)
        let pod = myPods?.filter({ ($0.id == idPod)})
        if !(pod?.isEmpty ?? false) {
            myPodsIcon = #imageLiteral(resourceName: "starIconNotFilled").withRenderingMode(.alwaysTemplate)
            MyPodsDAO.delete(myPod: pod!.first!)
        }
        else {
            MyPodsDAO.add(id: idPod, icon: iconPod, title: titlePod)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myPodsIcon, style: UIBarButtonItem.Style.done, target: self, action: #selector(performStar))
    }
    
}

extension PodCastListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContentTableViewCell()
        let urlImg: URL? = URL(string: pods[indexPath.item].thumbnail ?? pods[indexPath.item].image ?? podInfo.thumbnail ?? podInfo.image ?? bestPod.thumbnail ?? bestPod.image ?? podCastSearch.thumbnail ?? podCastSearch.image ?? "")
        if urlImg != nil {
            let request2 = ImageRequest(urlRequest: URLRequest(url: urlImg!))
            Nuke.loadImage(with: request2, into: cell.iconImageView)
        }
        cell.titleLabel.text = pods[indexPath.item].title
        cell.podCast = pods[indexPath.item]
        cell.idToSearch = idToSearch
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = HeaderPodCast()
//        headerView.podInfo = podInfo
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 120
//    }
    
}

extension PodCastListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pods.count - 1 {
            loadData()
        }
    }
}

extension PodCastListViewController: DownloadManagerDelegate {
    
    func downloadSucess(url: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

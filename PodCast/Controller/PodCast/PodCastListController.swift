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
    
    var myPods: MyPods? = nil
    
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
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
    }
    
    func starLoad() {
        myPods = MyPodsDataController.getMyPods()
        var myPodsIcon =  #imageLiteral(resourceName: "starIconNotFilled").withRenderingMode(.alwaysTemplate)
        if myPods != nil && podInfo != nil && !myPods!.id!.isEmpty && myPods!.id!.contains(podInfo.id ?? "") {
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
                        self.setupViews()
                        self.starLoad()
                    }
                    else {
                        if self.pods.isEmpty {
                            for element in SavedPodDAO.get().filter({ ($0.idPod == self.idToSearch) }) {
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
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: contentCellIdentifier)
        tableView.reloadData()
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    @objc func performStar() {
        let idPod = bestPod?.id ?? podCastSearch?.id ?? ""
        let iconPod = bestPod?.image ?? podCastSearch?.thumbnail ?? ""
        let titlePod = bestPod?.title ?? bestPod?.image ?? podCastSearch?.title_original ?? ""
        var id : [String] = myPods?.id ?? []
        var icon : [String] = myPods?.icon ?? []
        var title : [String] = myPods?.title ?? []
        var myPodsIcon =  #imageLiteral(resourceName: "starIconFilled").withRenderingMode(.alwaysTemplate)
        if myPods != nil && !myPods!.id!.isEmpty && myPods!.id!.contains(idPod) {
            myPodsIcon = #imageLiteral(resourceName: "starIconNotFilled").withRenderingMode(.alwaysTemplate)
            for i in 0...myPods!.id!.count - 1 {
                if myPods?.id![i] == idPod {
                    id.remove(at: i)
                    icon.remove(at: i)
                    title.remove(at: i)
                }
            }
        }
        else {
           id = myPods?.id ?? []
           id.append(idPod )
           icon = myPods?.icon ?? []
           icon.append(iconPod )
           title = myPods?.title ?? []
           title.append(titlePod )
        }
        MyPodsDataController.saveMyPods(id: id, icon: icon, title: title)
        myPods = MyPodsDataController.getMyPods()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myPodsIcon, style: UIBarButtonItem.Style.done, target: self, action: #selector(performStar))
    }
    
}

extension PodCastListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contentCellIdentifier, for: indexPath) as! ContentTableViewCell
        let urlImg: URL? = URL(string: pods[indexPath.item].thumbnail ?? pods[indexPath.item].image ?? "")
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


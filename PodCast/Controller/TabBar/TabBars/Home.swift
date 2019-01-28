//
//  Home.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

class Home: CustomViewController,UITableViewDelegate,UITableViewDataSource {
    
    var genres = [Genre]()
    var bestPods = [[BestPod]]()
    var list = 10
    
    var audioPlayerBar = AudioPlayerBarView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        if PlayerController.player != nil && PlayerController.player?.rate != 0 {
            setupPlayerBar()
        }
    }
    
    override func viewDidLoad() {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        audioPlayerBar.removeFromSuperview()
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupPlayerBar() {
        
        tableView.removeFromSuperview()
        audioPlayerBar = PlayerController.audioPlayerBar
        view.addSubview(audioPlayerBar)
        audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
    }
    
    func loadData() {
        startLoad()
        PodCastListService.getGenres { result in
            if result != nil {
                self.genres = result!
                var genresAux = [Genre]()
                for i in 0...2 {
                    genresAux.append(self.genres[i])
                }
                PodCastListService.getBestPodsByGenre(genres: genresAux, completionHandler: { resultBestPods in
                    if resultBestPods != nil {
                        self.bestPods = resultBestPods!
                    }
                    self.stopLoad()
                    self.tableView.reloadData()
                })
            }
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

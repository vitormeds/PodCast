//
//  Home.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

class Home: CustomTableViewController {
    
    var genres = [Genre]()
    var bestPods = [[BestPod]]()
    var list = 10
    
    override func viewDidLoad() {
        tableView.register(CollectionCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        loadData()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CollectionCell
        cell.bestPods = bestPods[indexPath.section]
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headeView = HeaderView()
        headeView.titleLabel.text = genres[section].name
        return headeView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return bestPods.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension Home: SelectBestPodDelegate {
    
    func selectPod(id: String) {
        let playerViewController = PlayerViewController()
        playerViewController.id = id
        let player = UINavigationController(rootViewController: playerViewController)
        present(player, animated: true)
    }
}

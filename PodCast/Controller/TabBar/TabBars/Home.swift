//
//  Home.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class Home: UITableViewController {
    
    var genres = [Genre]()
    
    override func viewDidLoad() {
        tableView.register(CategoryRow.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        loadData()
    }
    
    func loadData() {
        PodCastListService.getGenres { result in
            if result != nil {
                self.genres = result!
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        cell.card1.titleLabel.text = "Title"
        cell.card1.nameLabel.text = "Name"
        cell.card2.titleLabel.text = "Title"
        cell.card2.nameLabel.text = "Name"
        cell.card3.titleLabel.text = "Title"
        cell.card3.nameLabel.text = "Name"
        cell.card4.titleLabel.text = "Title"
        cell.card4.nameLabel.text = "Name"
        cell.card5.titleLabel.text = "Title"
        cell.card5.nameLabel.text = "Name"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return genres[section].name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

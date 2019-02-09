//
//  UIView.swift
//  PodCast
//
//  Created by Vitor Mendes on 25/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

open class CustomViewController: UIViewController {

    var audioPlayerBar = AudioPlayerBarView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CollectionCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let lottieLoading: LOTAnimationView = {
        let headerAnimationView = LOTAnimationView(name: "loadAnimation")
        headerAnimationView.translatesAutoresizingMaskIntoConstraints = false
        headerAnimationView.loopAnimation = true
        headerAnimationView.play() { _ in
            headerAnimationView.removeFromSuperview()
        }
        return headerAnimationView
    }()
    
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
    
    func setupTableView(topAnchor: NSLayoutYAxisAnchor? = nil) {
        audioPlayerBar.removeFromSuperview()
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if topAnchor != nil {
            tableView.topAnchor.constraint(equalTo: topAnchor!).isActive = true
        }
        else {
            tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupPlayerBar() {
        
        tableView.removeFromSuperview()
        audioPlayerBar = PlayerController.audioPlayerBar
        view.addSubview(audioPlayerBar)
        audioPlayerBar.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        audioPlayerBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        audioPlayerBar.closeButton.addTarget(self, action: #selector(closePlayerBar), for: .touchDown)
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: audioPlayerBar.topAnchor).isActive = true
    }
    
    @objc func closePlayerBar() {
        setupTableView()
        PlayerController.player?.pause()
    }
}

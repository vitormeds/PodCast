//
//  ViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 27/12/18.
//  Copyright © 2018 Vitor Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Nuke

class PlayerViewController: CustomViewController  {
    
    var id = ""
    var podCastData: Podcast!
    
    var audioPlayerView = AudioPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        loadData()
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    func loadData() {
        startLoad()
        PodCastListService.getBestPodById(id: id) { resultPodCast in
            if resultPodCast != nil {
                self.podCastData = resultPodCast
                self.setupViews()
            }
            self.stopLoad()
        }
    }
    
    func setupViews() {
        PlayerController.inicialize(podCastData: podCastData)
        audioPlayerView = PlayerController.audioPlayerView
        view.addSubview(audioPlayerView)
        audioPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        audioPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        audioPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        audioPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}



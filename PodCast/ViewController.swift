//
//  ViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 26/12/18.
//  Copyright © 2018 Vitor Mendes. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        audioPlayer()
    }
    
    func audioPlayer(){
        let url  = URL.init(string: "https://www.listennotes.com/e/p/a56476b08cc84fb5b90a236c3a920778/")
        
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        
        player.play()
    }


}


//
//  TestViewController.swift
//  PodCast
//
//  Created by Vitor Mendes on 08/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class TestViewController: UIViewController {
    
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    override func viewDidLoad() {
        downloadPodCast(url: "https://hwcdn.libsyn.com/p/8/c/b/8cb03e6b082b9664/Jay_Campbell_Final.mp3?c_id=45525581&cs_id=45525581&destination_id=966710&expiration=1562608524&hwt=1b79a6daa235e71c1b83bcfab6baeaa4")
    }
    
    func downloadPodCast(url: String) {
        if let audioUrl = URL(string: url) {
            
            // then lets create your document folder url
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectoryURL = paths[0]
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                
//                let assets = AVAsset(url: destinationUrl)
//                let playerItem = AVPlayerItem(asset: assets)
//                let player = AVPlayer(playerItem: playerItem)
//                player.play()
                
                do {
                    playerItem = AVPlayerItem(url: destinationUrl)
                    player = AVPlayer(playerItem: playerItem)
                    player!.play()
                } catch let error {
                    print(error.localizedDescription)
                }
                
                return
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else {
                        return
                    }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                        
                        let playerItem = AVPlayerItem(url: destinationUrl)
                        let player = AVPlayer(playerItem: playerItem)
                        player.play()
                        
                        return
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        return
                    }
                }).resume()
            }
        }
    }
}

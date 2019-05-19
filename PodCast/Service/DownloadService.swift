//
//  DownloadService.swift
//  PodCast
//
//  Created by Vitor Mendes on 18/05/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class DownloadService {
    
    static func downloadPodCast(url: String,completionHandler: @escaping (Bool) -> ()) {
        if let audioUrl = URL(string: url) {
        
        // then lets create your document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
        print(destinationUrl)
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
            completionHandler(false)
            return
        // if the file doesn't exist
        } else {
        
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                guard let location = location, error == nil else {
                        completionHandler(false)
                        return
                    }
                    do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                        
                        let playerItem = AVPlayerItem(url: destinationUrl)
                        let player = AVPlayer(playerItem: playerItem)
                        player.play()
                        
                        completionHandler(true)
                        return
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler(false)
                        return
                    }
                }).resume()
            }
        }
        else {
            completionHandler(false)
            return
        }
    }
}

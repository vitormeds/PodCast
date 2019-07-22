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
    
    static func downloadPodCast(podCast: Podcast,completionHandler: @escaping (String) -> ()) {
        if let audioUrl = URL(string: podCast.audio!) {
        if SavedPodDAO.get().contains(where: { ($0.id == podCast.id) } ) {
            completionHandler("")
            return
        } else {
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                guard let location = location, error == nil else {
                        completionHandler("")
                        return
                    }
                    // then lets create your document folder url
                    let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    
                    // lets create your destination file url
                    let destinationUrl = documentsDirectoryURL.appendingPathComponent((response?.url?.lastPathComponent)!)
                    // you can use NSURLSession.sharedSession to download the data asynchronously
                    do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                        
//                        let playerItem = AVPlayerItem(url: destinationUrl)
//                        let player = AVPlayer(playerItem: playerItem)
//                        player!.play()
                        
                        completionHandler(destinationUrl.description)
                        return
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler("")
                        return
                    }
                }).resume()
            }
        }
        else {
            completionHandler("")
            return
        }
    }
}

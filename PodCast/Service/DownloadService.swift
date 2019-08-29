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

class DownloadService: DownloadManagerDelegate {
    
    var downloadManagerDelegate: DownloadManagerDelegate!
    
    func verifyQueue() {
        
    }
    
    func downloadPodCast(podCast: Podcast) {
        if let audioUrl = URL(string: podCast.audio!) {
        if SavedPodDAO.get().contains(where: { ($0.id == podCast.id && $0.download == true) } ) {
            downloadManagerDelegate.downloadSucess(url: "")
            return
        } else {
                let downloadManager = DownloadManager.shared
                downloadManager.downloadManagerDelegate = self
                let task = downloadManager.activate().downloadTask(with: audioUrl)
                task.resume()
            }
        }
        else {
            downloadManagerDelegate.downloadSucess(url: "")
            return
        }
    }
    
    func downloadSucess(url: String) {
        downloadManagerDelegate.downloadSucess(url: url)
    }
}

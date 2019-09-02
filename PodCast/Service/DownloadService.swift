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
    
    var savedPod: SavedPods!
    
    func verifyQueue() {
        
        let queue = QueueDAO.get()
        if !queue.isEmpty {
            let queuePod = SavedPodDAO.get().filter { ($0.id == queue.first?.id && $0.idPod == queue.first?.idPod)}.first
            let pod = Podcast(audio_length: nil,
                              image: queuePod!.icon,
                              title: queuePod!.title,
                              listennotes_edit_url: nil,
                              explicit_content: nil,
                              audio: queuePod!.url,
                              pub_date_ms: nil,
                              podcast: nil,
                              description: queuePod!.descriptionPod,
                              id: queuePod!.id,
                              thumbnail: queuePod!.icon,
                              listennotes_url: nil,
                              maybe_audio_invalid: nil,
                              isDownload: true)
            self.savedPod = queuePod
            downloadPodCast(podCast: pod)
        }
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
        if !url.isEmpty {
            self.savedPod.url = url
            SavedPodDAO.update(savedPod: self.savedPod)
            let pods = QueueDAO.get().filter({ ($0.id == self.savedPod.id && $0.idPod == self.savedPod.idPod)})
            for element in pods {
                QueueDAO.delete(queuePod: element)
            }
        }
        verifyQueue()
        downloadManagerDelegate.downloadSucess(url: url)
    }
}

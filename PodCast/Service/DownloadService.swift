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
    
    var isDownload = false
    
    func updateSavedPod(sucess: @escaping (SavedPods?) -> (),fail: @escaping () -> ()) {
        let queue = QueueDAO.get()
        if !queue.isEmpty {
            let queuePod = SavedPodDAO.get().filter { ($0.id == queue.first?.id && $0.idPod == queue.first?.idPod)}.first
            self.savedPod = queuePod
            sucess(queuePod)
            return
        }
        else {
            fail()
            return
        }
    }
    
    func verifyQueue() {
        updateSavedPod(sucess: { queuePod in
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
            self.downloadPodCast(podCast: pod)
        }) {}
    }
    
    func downloadPodCast(podCast: Podcast) {
        if let audioUrl = URL(string: podCast.audio!) {
            if SavedPodDAO.get().contains(where: { ($0.id == podCast.id && $0.download == true) } ) {
                if downloadManagerDelegate != nil {
                    downloadManagerDelegate.downloadSucess(url: "")
                }
                return
            } else {
                if !isDownload {
                    isDownload = true
                    let downloadManager = DownloadManager.shared
                    downloadManager.downloadManagerDelegate = self
                    let task = downloadManager.activate().downloadTask(with: audioUrl)
                    task.resume()
                }
            }
        }
        else {
            if downloadManagerDelegate != nil {
                downloadManagerDelegate.downloadSucess(url: "")
            }
            return
        }
    }
    
    func downloadSucess(url: String) {
        updateSavedPod(sucess: { result in
            self.isDownload = false
            if !url.isEmpty {
                self.savedPod.url = url
                SavedPodDAO.update(savedPod: self.savedPod)
                let pods = QueueDAO.get().filter({ ($0.id == self.savedPod.id && $0.idPod == self.savedPod.idPod)})
                for element in pods {
                    QueueDAO.delete(queuePod: element)
                }
            }
            self.verifyQueue()
            if self.downloadManagerDelegate != nil {
                self.downloadManagerDelegate.downloadSucess(url: url)
            }
        }) {}
    }
}

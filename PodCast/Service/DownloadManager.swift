//
//  DownloadMananger.swift
//  PodCast
//
//  Created by Vitor on 29/08/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

protocol DownloadManagerDelegate {
    func downloadSucess(url: String)
}

class DownloadManager : NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    static var shared = DownloadManager()
    
    var downloadManagerDelegate: DownloadManagerDelegate!
    
    typealias ProgressHandler = (Float) -> ()
    
    var onProgress : ProgressHandler? {
        didSet {
            if onProgress != nil {
                let _ = activate()
            }
        }
    }
    
    override private init() {
        super.init()
    }
    
    func activate() -> URLSession {
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        
        // Warning: If an URLSession still exists from a previous download, it doesn't create a new URLSession object but returns the existing one with the old delegate object attached!
        return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
    }
    
    private func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
            completionHandler(progress.reduce(0.0, +))
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if totalBytesExpectedToWrite > 0 {
            if let onProgress = onProgress {
                calculateProgress(session: session, completionHandler: onProgress)
            }
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            debugPrint("Progress \(downloadTask) \(progress)")
            
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent((downloadTask.response?.url?.lastPathComponent)!)
            // you can use NSURLSession.sharedSession to download the data asynchronously
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                do {
                    try FileManager.default.removeItem(at: destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            do {
            // after downloading your file you need to move it to your destination url
            try FileManager.default.moveItem(at: location, to: destinationUrl)
                print("File moved to documents folder")

                downloadManagerDelegate.downloadSucess(url: (downloadTask.response?.url?.lastPathComponent)!)
                return
            } catch let error as NSError {
                print(error.localizedDescription)
                downloadManagerDelegate.downloadSucess(url: "")
                return
            }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint("Task completed: \(task), error: \(error)")
    }
}

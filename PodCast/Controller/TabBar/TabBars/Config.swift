//
//  Config.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class Config: UIViewController {
    
    let clearDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remover Dados", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        
        view.addSubview(clearDataButton)
        clearDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clearDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        clearDataButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        clearDataButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        clearDataButton.addTarget(self, action: #selector(performClearData), for: UIControl.Event.touchDown)
    }
    
    @objc func performClearData() {
        let fileManager = FileManager.default
        let documentsUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as NSURL
        let documentsPath = documentsUrl.path
        
        do {
            if let documentPath = documentsPath
            {
                let fileNames = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache: \(fileNames)")
                for fileName in fileNames {
                    let filePathName = "\(documentPath)/\(fileName)"
                    try fileManager.removeItem(atPath: filePathName)
                }
                
                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
                print("all files in cache after deleting images: \(files)")
            }
            
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
}

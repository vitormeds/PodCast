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
        button.layer.borderColor = UIColor.secondary.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle("Remover Dados", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        
        view.addSubview(clearDataButton)
        clearDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clearDataButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        clearDataButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        clearDataButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        clearDataButton.addTarget(self, action: #selector(performClearData), for: UIControl.Event.touchDown)
    }
    
    @objc func performClearData() {
        let pods = SavedPodDAO.get()
        
        for element in pods {
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(element.url ?? "")
            debugPrint(destinationUrl)
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                do {
                    try FileManager.default.removeItem(at: destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }

        SavedPodDAO.deleteAll()
        QueueDAO.deleteAll()
    }
}

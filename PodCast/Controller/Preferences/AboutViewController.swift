//
//  AboutViewController.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var delegate: ListUpdateDelegate!
    
    let iconPodCat: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "podCat")
        img.layer.cornerRadius = 14
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.white
        textLabel.text = R.string.localizable.aboutString()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        setupViews()
    }
    
    func setupViews() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.voltar(), style: .done, target: self, action: #selector(performBack))
        
        view.addSubview(iconPodCat)
        iconPodCat.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        iconPodCat.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconPodCat.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iconPodCat.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: iconPodCat.bottomAnchor, constant: 16).isActive = true
        textLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    @objc func performBack() {
        delegate.loadData()
        dismiss(animated: true)
    }
}

//
//  PurchaseViewController.swift
//  PodCast
//
//  Created by Vitor on 04/02/20.
//  Copyright © 2020 Vitor Mendes. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    
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
    
    let clearDataButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.secondary.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle(R.string.localizable.removeData(), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        view.addSubview(clearDataButton)
        clearDataButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        clearDataButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        clearDataButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16).isActive = true
        clearDataButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        clearDataButton.addTarget(self, action: #selector(performClear), for: UIControl.Event.touchDown)
    }
    
    @objc func performBack() {
        dismiss(animated: true)
    }
    
    @objc func performClear() {
        IAProducts.store.requestProducts(completionHandler: {
            (status, productsOptional) in
            if status && !(productsOptional?.isEmpty ?? true) {
                IAProducts.store.buyProduct((productsOptional?.first)!)
            }
        })
    }
}

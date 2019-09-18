//
//  SingInViewController.swift
//  PodCast
//
//  Created by Vitor on 18/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class SingInViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.primary
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//
//  UIView.swift
//  PodCast
//
//  Created by Vitor Mendes on 25/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Lottie

open class CustomViewController: UIViewController {
    
    let lottieLoading: LOTAnimationView = {
        let headerAnimationView = LOTAnimationView(name: "loadAnimation")
        headerAnimationView.translatesAutoresizingMaskIntoConstraints = false
        headerAnimationView.loopAnimation = true
        headerAnimationView.play() { _ in
            headerAnimationView.removeFromSuperview()
        }
        return headerAnimationView
    }()
    
    func startLoad() {
        view.addSubview(lottieLoading)
        lottieLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lottieLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lottieLoading.heightAnchor.constraint(equalToConstant: 100).isActive = true
        lottieLoading.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func stopLoad() {
        lottieLoading.removeFromSuperview()
    }
}

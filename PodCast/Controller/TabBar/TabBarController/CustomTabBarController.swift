//
//  CustomTabBarController.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class CustomTabBarController: RAMAnimatedTabBarController {
    
    override func viewDidLoad() {
        
        UITabBar.appearance().tintColor = UIColor.secondary
        UITabBar.appearance().barTintColor = UIColor.primary
        
        let animation = RAMBounceAnimation()
        animation.iconSelectedColor = UIColor.secondary
        animation.textSelectedColor = UIColor.secondary
        
        let homeViewController = Home()
        let homeViewNavigationController = homeViewController
        homeViewNavigationController.title = R.string.localizable.inicio()
        let homeTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.inicio(), image: UIImage(named: "home"), tag: 0)
        homeTabBar.animation = animation
        homeTabBar.textColor = UIColor.secondary
        homeTabBar.iconColor = UIColor.secondary
        homeViewNavigationController.tabBarItem = homeTabBar
        
        let myPodCastsViewController = MyPodCasts()
        let myPodCastsViewNavigationController = myPodCastsViewController
        myPodCastsViewNavigationController.title = R.string.localizable.meusPodCast()
        let headPhoneTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.meuspodcasts(), image: UIImage(named: "headphone"), tag: 1)
        headPhoneTabBar.animation = animation
        headPhoneTabBar.textColor = UIColor.secondary
        headPhoneTabBar.iconColor = UIColor.secondary
        myPodCastsViewNavigationController.tabBarItem = headPhoneTabBar
        
        let configViewController = Config()
        let configViewNavigationController = configViewController
        configViewNavigationController.title = R.string.localizable.perfil()
        let configTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.configuracoes(), image: UIImage(named: "profile"), tag: 2)
        configTabBar.animation = animation
        configTabBar.textColor = UIColor.secondary
        configTabBar.iconColor = UIColor.secondary
        configViewNavigationController.tabBarItem = configTabBar
        
        viewControllers = [homeViewNavigationController,myPodCastsViewNavigationController,configViewNavigationController]
    }
}

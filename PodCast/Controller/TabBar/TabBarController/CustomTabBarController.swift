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
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.black
        
        let animation = CustomAnimation()
        animation.iconSelectedColor = UIColor.white
        animation.textSelectedColor = UIColor.white
        
        let homeViewController = Home()
        let homeViewNavigationController = homeViewController
        homeViewNavigationController.title = R.string.localizable.inicio()
        let homeTabBar = RAMAnimatedTabBarItem(title: "Inicio", image: UIImage(named: "home"), tag: 0)
        homeTabBar.animation = animation
        homeTabBar.textColor = UIColor.white
        homeTabBar.iconColor = UIColor.white
        homeViewNavigationController.tabBarItem = homeTabBar
        
        let myPodCastsViewController = MyPodCasts()
        let myPodCastsViewNavigationController = myPodCastsViewController
        myPodCastsViewNavigationController.title = R.string.localizable.meusPodCast()
        let headPhoneTabBar = RAMAnimatedTabBarItem(title: "Meus Pod Casts", image: UIImage(named: "headphone"), tag: 1)
        headPhoneTabBar.animation = animation
        headPhoneTabBar.textColor = UIColor.white
        headPhoneTabBar.iconColor = UIColor.white
        myPodCastsViewNavigationController.tabBarItem = headPhoneTabBar
        
        let configViewController = Config()
        let configViewNavigationController = configViewController
        configViewNavigationController.title = R.string.localizable.perfil()
        let configTabBar = RAMAnimatedTabBarItem(title: "Configuração", image: UIImage(named: "profile"), tag: 2)
        configTabBar.animation = animation
        configTabBar.textColor = UIColor.white
        configTabBar.iconColor = UIColor.white
        configViewNavigationController.tabBarItem = configTabBar
        
        viewControllers = [homeViewNavigationController,myPodCastsViewNavigationController,configViewNavigationController]
    }
}

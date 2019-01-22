//
//  CustomTabBarController.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.black

        let homeViewController = Home()
        let homeViewNavigationController = homeViewController
        homeViewNavigationController.title = "Inicio"
        homeViewNavigationController.tabBarItem.image = UIImage(named: "home")
        
        let myPodCastsViewController = MyPodCasts()
        let myPodCastsViewNavigationController = myPodCastsViewController
        myPodCastsViewNavigationController.title = "Meus Podcasts"
        myPodCastsViewNavigationController.tabBarItem.image = UIImage(named: "headphone")
        
        let configViewController = Config()
        let configViewNavigationController = configViewController
        configViewNavigationController.title = "Perfil"
        configViewNavigationController.tabBarItem.image = UIImage(named: "profile")
        
        viewControllers = [homeViewNavigationController,myPodCastsViewNavigationController,configViewNavigationController]
    }
}
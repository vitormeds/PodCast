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
    
    let homeViewNavigationController = Home()
    let myPodCastsViewNavigationController = MyPodCasts()
    let configViewNavigationController = Config()
    
    override func viewDidLoad() {
        
        IAProducts.store.restorePurchases(homeViewNavigationController: homeViewNavigationController, myPodCastsViewNavigationController: myPodCastsViewNavigationController, configViewNavigationController: configViewNavigationController)
        if IAProducts.store.isProductPurchased(IAProducts.premium) {
            Ad.isPremium = true
        } else  {
            Ad.isPremium = false
        }
        
        UITabBar.appearance().tintColor = UIColor.secondary
        UITabBar.appearance().barTintColor = UIColor.primary
        
        let animation = RAMBounceAnimation()
        animation.iconSelectedColor =
            UIColor.secondary
        animation.textSelectedColor = UIColor.secondary
        
        homeViewNavigationController.title = R.string.localizable.inicio()
        let homeTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.inicio(), image: UIImage(named: "home"), tag: 0)
        homeTabBar.animation = animation
        homeTabBar.textColor = UIColor.secondary
        homeTabBar.iconColor = UIColor.secondary
        homeViewNavigationController.tabBarItem = homeTabBar
        
        
        myPodCastsViewNavigationController.title = R.string.localizable.meusPodCast()
        let headPhoneTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.meuspodcasts(), image: UIImage(named: "headphone"), tag: 1)
        headPhoneTabBar.animation = animation
        headPhoneTabBar.textColor = UIColor.secondary
        headPhoneTabBar.iconColor = UIColor.secondary
        myPodCastsViewNavigationController.tabBarItem = headPhoneTabBar
        
        configViewNavigationController.title = R.string.localizable.perfil()
        let configTabBar = RAMAnimatedTabBarItem(title: R.string.localizable.configuracoes(), image: UIImage(named: "profile"), tag: 2)
        configTabBar.animation = animation
        configTabBar.textColor = UIColor.secondary
        configTabBar.iconColor = UIColor.secondary
        configViewNavigationController.tabBarItem = configTabBar
        
        viewControllers = [homeViewNavigationController,myPodCastsViewNavigationController,configViewNavigationController]
    }
}

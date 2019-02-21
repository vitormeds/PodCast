//
//  CustomAnimation.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation
import RAMAnimatedTabBarController

class CustomAnimation : RAMItemAnimation {
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        var pulseEffect = LFTPulseAnimation(repeatCount: 0, radius:40, position: CGPoint(x: icon.frame.width/2, y: icon.frame.height/2))
        icon.layer.insertSublayer(pulseEffect, below: icon.layer)
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}

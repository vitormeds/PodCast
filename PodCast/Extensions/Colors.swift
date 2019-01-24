//
//  Colors.swift
//  PodCast
//
//  Created by Vitor Mendes on 21/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

extension UIColor {
    
    open class var primary: UIColor {
        get {
            return UIColor.black
        }
    }
    
    open class var secondary: UIColor {
        return UIColor.white
    }
    
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

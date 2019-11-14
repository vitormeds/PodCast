//
//  AplicationUtil.swift
//  PodCast
//
//  Created by Vitor Mendes on 08/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class AplicationUtil {
    
    static func getViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        else {
            return nil
        }
    }
    
    static func performAlert(title: String,description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        getViewController()?.present(alert, animated: true, completion: nil)
    }
}

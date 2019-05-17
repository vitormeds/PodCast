//
//  MyPodsController.swift
//  PodCast
//
//  Created by Vitor Mendes on 17/05/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class MyPodsDataController {
    
    static func saveMyPods(myPods: [String]) {
        let myPodsData = MyPods(id: myPods)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myPodsData)
        UserDefaults.standard.set(encodedData, forKey: "MyPods")
    }
    
    static func getMyPods() -> MyPods? {
        var myPodsData = MyPods()
        if let data = UserDefaults.standard.data(forKey: "MyPods") {
            myPodsData  = (NSKeyedUnarchiver.unarchiveObject(with: data) as? MyPods)!
            return myPodsData
        }
        return nil
    }
}

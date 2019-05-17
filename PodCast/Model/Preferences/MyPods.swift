//
//  MyPods.swift
//  PodCast
//
//  Created by Vitor Mendes on 17/05/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class MyPods: NSObject , NSCoding {
    
    var id: [String]?
    var icon: [String]?
    var title: [String]?
    
    override init() {
        super.init()
    }
    
    init(id: [String],icon: [String],title: [String]) {
        super.init()
        self.id = id
        self.icon = icon
        self.title = title
    }
    
    required init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? [String] {
            self.id = id
        }
        if let icon = aDecoder.decodeObject(forKey: "icon") as? [String] {
            self.icon = icon
        }
        if let title = aDecoder.decodeObject(forKey: "title") as? [String] {
            self.title = title
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let id = self.id {
            aCoder.encode(id, forKey: "id")
        }
        if let icon = self.icon {
            aCoder.encode(icon, forKey: "icon")
        }
        if let title = self.title {
            aCoder.encode(title, forKey: "title")
        }
    }
    
}

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
    
    override init() {
        super.init()
    }
    
    init(id: [String]) {
        super.init()
        self.id = id
    }
    
    required init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? [String] {
            self.id = id
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let id = self.id {
            aCoder.encode(id, forKey: "id")
        }
    }
    
}

//
//  Preferences.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class Preferences: NSObject , NSCoding{
    
    var parent_id: [Int]?
    var name: [String]?
    var id: [Int]?
    
    
    override init() {
        super.init()
    }
    
    init(parent_id: [Int],name: [String],id: [Int]) {
        super.init()
        self.parent_id = parent_id
        self.name = name
        self.id = id
    }
    
    required init(coder aDecoder: NSCoder) {
        if let parent_id = aDecoder.decodeObject(forKey: "parent_id") as? [Int] {
            self.parent_id = parent_id
        }
        if let name = aDecoder.decodeObject(forKey: "name") as? [String] {
            self.name = name
        }
        if let id = aDecoder.decodeObject(forKey: "id") as? [Int] {
            self.id = id
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let parent_id = self.parent_id {
            aCoder.encode(parent_id, forKey: "parent_id")
        }
        if let name = self.name {
            aCoder.encode(name, forKey: "name")
        }
        if let id = self.id {
            aCoder.encode(id, forKey: "id")
        }
    }
    
}

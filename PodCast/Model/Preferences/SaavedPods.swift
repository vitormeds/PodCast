//
//  SavedPods.swift
//  PodCast
//
//  Created by Vitor Mendes on 15/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class SaavedPods: NSObject , NSCoding {
    
    var id: [String]?
    var idPod: [String]?
    var icon: [String]?
    var title: [String]?
    var url: [String]?
    
    override init() {
        super.init()
    }
    
    init(id: [String],idPod: [String],icon: [String],title: [String],url: [String]) {
        super.init()
        self.id = id
        self.idPod = idPod
        self.icon = icon
        self.title = title
        self.url = url
    }
    
    required init(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObject(forKey: "id") as? [String] {
            self.id = id
        }
        if let idPod = aDecoder.decodeObject(forKey: "idPod") as? [String] {
            self.idPod = idPod
        }
        if let icon = aDecoder.decodeObject(forKey: "icon") as? [String] {
            self.icon = icon
        }
        if let title = aDecoder.decodeObject(forKey: "title") as? [String] {
            self.title = title
        }
        if let url = aDecoder.decodeObject(forKey: "url") as? [String] {
            self.url = url
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let id = self.id {
            aCoder.encode(id, forKey: "id")
        }
        if let idPod = self.idPod {
            aCoder.encode(idPod, forKey: "idPod")
        }
        if let icon = self.icon {
            aCoder.encode(icon, forKey: "icon")
        }
        if let title = self.title {
            aCoder.encode(title, forKey: "title")
        }
        if let url = self.url {
            aCoder.encode(url, forKey: "url")
        }
    }
    
}

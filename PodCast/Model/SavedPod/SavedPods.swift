//
//  SavedPods+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SavedPods)
public class SavedPods: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPods> {
        return NSFetchRequest<SavedPods>(entityName: "SavedPods")
    }
    
    @NSManaged public var descriptionPod: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var idPod: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    
    func fillWith(descriptionPod: String,icon: String,id: String,idPod: String,title: String,url: String) {
        self.descriptionPod = descriptionPod
        self.icon = icon
        self.id = id
        self.idPod = idPod
        self.title = title
        self.url = url
    }
}

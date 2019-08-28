//
//  SavedPods+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor Mendes on 23/07/19.
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
    @NSManaged public var audio_length: Int64
    @NSManaged public var download: Bool
    
    func fillWith(descriptionPod: String,icon: String,id: String,idPod: String,title: String,url: String,audio_length: Int,download: Bool) {
        self.descriptionPod = descriptionPod
        self.icon = icon
        self.id = id
        self.idPod = idPod
        self.title = title
        self.url = url
        self.audio_length = Int64(audio_length)
        self.download = download
    }
}

//
//  SavedPods+CoreDataProperties.swift
//  PodCast
//
//  Created by Vitor Mendes on 23/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedPods {

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

}

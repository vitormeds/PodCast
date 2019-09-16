//
//  Preferences+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor on 16/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Preferences)
public class Preferences: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Preferences> {
        return NSFetchRequest<Preferences>(entityName: "Preferences")
    }
    
    @NSManaged public var parent_id: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    
    func fillWith(parent_id: String,id: String,name: String) {
        self.parent_id = parent_id
        self.name = name
        self.id = id
    }
}

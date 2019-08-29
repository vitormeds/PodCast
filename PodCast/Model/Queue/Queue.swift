//
//  Queue+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor on 29/08/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Queue)
public class Queue: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Queue> {
        return NSFetchRequest<Queue>(entityName: "Queue")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var idPod: String?
    
    func fillWith(id: String,idPod: String) {
        self.id = id
        self.idPod = idPod
    }
}

//
//  MyPods+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor on 16/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MyPods)
public class MyPods: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPods> {
        return NSFetchRequest<MyPods>(entityName: "MyPods")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var icon: String?
    @NSManaged public var title: String?
    
    
    func fillWith(id: String,icon: String,title: String) {
        self.icon = icon
        self.id = id
        self.title = title
    }
}

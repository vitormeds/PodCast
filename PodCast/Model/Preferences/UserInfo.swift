//
//  UserInfo+CoreDataClass.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserInfo)
public class UserInfo: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var language: String?
    @NSManaged public var locationdescription: String?
    
    func fillWith(name: String,location: String,language: String,locationdescription: String) {
        self.name = name
        self.location = location
        self.language = language
        self.locationdescription = locationdescription
    }
}

//
//  UserInfoDAO.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import CoreData

class UserInfoDAO {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func get() -> [UserInfo] {
        
        let fetchRequest = NSFetchRequest<UserInfo>(entityName: "UserInfo")
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
    
    static func add(name: String? = nil,location: String? = nil,language: String? = nil,locationdescription: String? = nil) {
        let user = get()
        if user.isEmpty {
            let userInfo = UserInfo(context: context)
            userInfo.fillWith(name: name ?? "", location: location ?? "", language: language ?? "", locationdescription: locationdescription ?? "")
        }
        else {
            user.first?.name = name ?? user.first?.name
            user.first?.language = language ?? user.first?.language
            user.first?.location = location ?? user.first?.location
            user.first?.locationdescription = locationdescription ?? user.first?.locationdescription
        }
        try! context.save()
    }
    
    static func delete(userInfo: UserInfo) {
        context.delete(userInfo)
        try! context.save()
    }
    
    static func deleteAll() {
        let userInfos = get()
        for element in userInfos {
            delete(userInfo: element)
        }
    }
    
}

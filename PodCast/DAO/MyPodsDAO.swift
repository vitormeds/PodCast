//
//  MyPodsDAO.swift
//  PodCast
//
//  Created by Vitor on 16/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import CoreData

class MyPodsDAO {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func get() -> [MyPods] {
        
        let fetchRequest = NSFetchRequest<MyPods>(entityName: "MyPods")
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
    
    static func add(id: String,icon: String,title: String) {
        let myPods = MyPods(context: context)
        myPods.fillWith(id: id, icon: icon, title: title)
        try! context.save()
    }
    
    static func delete(myPod: MyPods) {
        context.delete(myPod)
        try! context.save()
    }
    
    static func deleteAll() {
        let myPods = get()
        for element in myPods {
            delete(myPod: element)
        }
    }
    
}

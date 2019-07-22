//
//  SavedPodDAO.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/07/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import CoreData

class SavedPodDAO {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func get() -> [SavedPods] {
        
        let fetchRequest = NSFetchRequest<SavedPods>(entityName: "SavedPods")
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
    
    static func add(descriptionPod: String,icon: String,id: String,idPod: String,title: String,url: String) {
        let savedPods = SavedPods(context: context)
        savedPods.fillWith(descriptionPod: descriptionPod,icon: icon,id: id,idPod: idPod,title: title,url: url)
        try! context.save()
    }
    
    static func delete(savedPod: SavedPods) {
        context.delete(savedPod)
        try! context.save()
    }
    
}

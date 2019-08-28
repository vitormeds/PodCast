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
    
    static func add(descriptionPod: String,icon: String,id: String,idPod: String,title: String,url: String,audio_length: Int,download: Bool) {
        let savedPods = SavedPods(context: context)
        savedPods.fillWith(descriptionPod: descriptionPod,icon: icon,id: id,idPod: idPod,title: title,url: url, audio_length: audio_length, download: download)
        try! context.save()
    }
    
    static func update(descriptionPod: String,icon: String,id: String,idPod: String,title: String,url: String,audio_length: Int,download: Bool) {
        
        let fetchRequest = NSFetchRequest<SavedPods>(entityName: "SavedPods")
        fetchRequest.predicate = NSPredicate(format: "idPod = %@", idPod)
        
        do {
            let obj = try context.fetch(fetchRequest)
            let objToUpdate = obj.first as! NSManagedObject
            objToUpdate.setValue(descriptionPod, forKey: "descriptionPod")
            objToUpdate.setValue(icon, forKey: "icon")
            objToUpdate.setValue(id, forKey: "id")
            objToUpdate.setValue(idPod, forKey: "idPod")
            objToUpdate.setValue(title, forKey: "title")
            objToUpdate.setValue(url, forKey: "url")
            objToUpdate.setValue(audio_length, forKey: "audio_length")
            objToUpdate.setValue(descriptionPod, forKey: "descriptionPod")
            
            try! context.save()
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    static func delete(savedPod: SavedPods) {
        context.delete(savedPod)
        try! context.save()
    }
    
}

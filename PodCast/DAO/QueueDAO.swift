//
//  QueueDAO.swift
//  PodCast
//
//  Created by Vitor on 29/08/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import CoreData

class QueueDAO {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func get() -> [Queue] {
        
        let fetchRequest = NSFetchRequest<Queue>(entityName: "Queue")
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
    
    static func add(id: String,idPod: String) {
        let queuePods = Queue(context: context)
        queuePods.fillWith(id: id,idPod: idPod)
        try! context.save()
    }
    
    static func delete(queuePod: Queue) {
        context.delete(queuePod)
        try! context.save()
    }
    
    static func deleteAll() {
        let queuePods = get()
        for element in queuePods {
            delete(queuePod: element)
        }
    }
    
}

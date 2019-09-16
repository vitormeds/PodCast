//
//  PreferencesDAO.swift
//  PodCast
//
//  Created by Vitor on 16/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import CoreData

class PreferencesDAO {
    
    static let parent_idAux = [82,67,67,88,93,100,67,67,127,67,67,68]
    static let nameAux = ["Video Games","Religion & Spirituality","Health","Fitness & Nutrition","Business News","Food","Education","Government & Organizations","Tech News","Comedy","Music","Movie"]
    static let idAux = [85,69,88,89,95,102,111,117,131,133,134,138]
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func get() -> [Preferences] {
        
        let fetchRequest = NSFetchRequest<Preferences>(entityName: "Preferences")
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print("Error with request: \(error)")
        }
        return []
    }
    
    
    
    
    static func add(genres: [Genre]) {
        var auxGenres = genres
        if genres.count < 5 {
            for i in 0...parent_idAux.count-1 {
                if !auxGenres.contains(where: { ($0.id == idAux[i])}) {
                    auxGenres.append(Genre(parent_id: parent_idAux[i], name: nameAux[i], id: idAux[i]))
                }
            }
        }
        for element in auxGenres {
            let preferences = Preferences(context: context)
            preferences.fillWith(parent_id: element.parent_id?.description ?? "", id: element.id?.description ?? "", name: element.name ?? "")
            try! context.save()
        }
    }
    
    static func delete(preference: Preferences) {
        context.delete(preference)
        try! context.save()
    }
    
    static func deleteAll() {
        let preferences = get()
        for element in preferences {
            delete(preference: element)
        }
    }
    
}

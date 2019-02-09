//
//  PreferencesDataController.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class PreferencesDataController {
    
    static let parent_idAux = [82,67,67,88,93,100,67,67,127,67,67,68]
    static let nameAux = ["Video Games","Religion & Spirituality","Health","Fitness & Nutrition","Business News","Food","Education","Government & Organizations","Tech News","Comedy","Music","Movie"]
    static let idAux = [85,69,88,89,95,102,111,117,131,133,134,138]
    
    static func savePreferences(genres: [Genre]) {
        var parent_id = [Int]()
        var name = [String]()
        var id = [Int]()
        for element in genres {
            parent_id.append(element.parent_id ?? 0)
            name.append(element.name ?? "")
            id.append(element.id ?? 0)
        }
        for i in 0...idAux.count - 1 {
            if !id.contains(idAux[i]) {
                id.append(idAux[i])
                name.append(nameAux[i])
                parent_id.append(parent_idAux[i])
            }
        }
        let preferences = Preferences(parent_id: parent_id, name: name, id: id)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: preferences)
        UserDefaults.standard.set(encodedData, forKey: "Preferences")
    }
    
    static func getPreferences() -> Preferences? {
        var preferences = Preferences()
        if let data = UserDefaults.standard.data(forKey: "Preferences") {
            preferences  = (NSKeyedUnarchiver.unarchiveObject(with: data) as? Preferences)!
            return preferences
        }
        return nil
    }
}

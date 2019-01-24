//
//  PreferencesDataController.swift
//  PodCast
//
//  Created by Vitor Mendes on 24/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit

class PreferencesDataController {
    
    static func savePreferences(genres: [Genre]) {
        var parent_id = [Int]()
        var name = [String]()
        var id = [Int]()
        for element in genres {
            parent_id.append(element.parent_id ?? 0)
            name.append(element.name ?? "")
            id.append(element.id ?? 0)
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

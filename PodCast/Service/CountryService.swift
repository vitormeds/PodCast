//
//  CountryService.swift
//  PodCast
//
//  Created by Vitor on 17/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountryService {
    
    static func getCountries(completionHandler: @escaping ([Country]?) -> ()) {
        
        let url = "https://listen-api.listennotes.com/api/v2/regions"
        let header = ["X-ListenAPI-Key" : "b8fc388d34c24d17ac2196341809e06f"]
        
        Alamofire.request(url, method: .get,headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            if let responseObj = try? JSONSerialization.jsonObject(with: data) {
                if let responseData = responseObj as? [String: Any] {
                    if let closeDtoList = responseData["regions"] as? [String: Any] {
                        var countries = [Country]()
                        for elementKey in closeDtoList.keys {
                            countries.append(Country(key: elementKey, value: closeDtoList[elementKey] as? String))
                        }
                        completionHandler(countries)
                        return
                    }
                }
            }
            completionHandler([])
            return
        }
    }
    
}

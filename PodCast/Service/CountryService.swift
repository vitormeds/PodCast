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
        
        let url = "https://restcountries.eu/rest/v2/all?fields=name"
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completionHandler(countries)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
            }
        }
    }
    
}

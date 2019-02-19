//
//  SearchService.swift
//  PodCast
//
//  Created by Vitor Mendes on 12/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchService {
    
    static let header = ["X-RapidAPI-Key" : "0799d534b1msh31d98431151274ap1a0de9jsnf346b2fbf029"]
    
    static func searchEpisodePodCast(search: String,completionHandler: @escaping ([EpisodeSearch]?) -> ()) {
        let searchText = search.replacingOccurrences(of: " ", with: "-")
        let url = "https://listennotes.p.rapidapi.com/api/v1/search?type=episode&q=" + searchText
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let pods = try JSONDecoder().decode(EpisodeSearchList.self, from: data)
                completionHandler(pods.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
    
    static func searchPodCast(search: String,completionHandler: @escaping ([PodCastSearch]?) -> ()) {
        let searchText = search.replacingOccurrences(of: " ", with: "-")
        let url = "https://listennotes.p.rapidapi.com/api/v1/search?type=podcas&q=" + searchText
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let pods = try JSONDecoder().decode(PodCastSearchList.self, from: data)
                completionHandler(pods.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
}

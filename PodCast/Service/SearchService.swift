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
    
    static let header = ["X-ListenAPI-Key" : "b8fc388d34c24d17ac2196341809e06f"]
    
    static func searchEpisodePodCast(search: String, next: String? = "",completionHandler: @escaping (EpisodeSearchList?) -> ()) {
        let searchText = search.replacingOccurrences(of: " ", with: "-")
        var url = "https://listen-api.listennotes.com/api/v2/search?type=episode&q=" + searchText
        if next != nil && next != ""{
            url = url + "&offset=" + next!
        }
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let pods = try JSONDecoder().decode(EpisodeSearchList.self, from: data)
                completionHandler(pods)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
    
    static func searchPodCast(search: String, next: String? = "",completionHandler: @escaping (PodCastSearchList?) -> ()) {
        let searchText = search.replacingOccurrences(of: " ", with: "-")
        var url = "https://listen-api.listennotes.com/api/v2/search?type=podcas&q=" + searchText
        if next != nil && next != "" {
            url = url + "&offset=" + next!
        }
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let pods = try JSONDecoder().decode(PodCastSearchList.self, from: data)
                completionHandler(pods)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
}

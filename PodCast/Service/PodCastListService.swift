//
//  PodCastListService.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PodCastListService {
    
    static var genresPods = 0
    static var bestPods = [[BestPod]]()
    
    static let header = ["X-RapidAPI-Key" : "0799d534b1msh31d98431151274ap1a0de9jsnf346b2fbf029"]
    
    static func getGenres(completionHandler: @escaping ([Genre]?) -> ()) {
       
        let url = "https://listennotes.p.rapidapi.com/api/v1/genres"
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let genre = try JSONDecoder().decode(GenreElement.self, from: data)
                completionHandler(genre.genres)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
            }
        }
    }
    
    static func getBestPodsByGenre(genres: [Genre],completionHandler: @escaping ([[BestPod]]?) -> ()) {
        
        let url = "https://listennotes.p.rapidapi.com/api/v1/best_podcasts?genre_id=" + "\(genres[genresPods].id!)"
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                let pods = try JSONDecoder().decode(BestPodElement.self, from: data)
                bestPods.append(pods.channels ?? [])
                genresPods += 1
                if bestPods.count == genres.count{
                    completionHandler(bestPods)
                    return
                }
                else {
                    getBestPodsByGenre(genres: genres, completionHandler: { result in
                        completionHandler(bestPods)
                        return
                    })
                }
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
    
    static func getBestPodById(id: String,completionHandler: @escaping (Podcast?) -> ()) {
        
        let url = "https://listennotes.p.rapidapi.com/api/v1/episodes/" + id
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                if !data.isEmpty {
                    let pod = try JSONDecoder().decode(Podcast.self, from: data)
                    if pod.audio == nil {
                        completionHandler(nil)
                        return
                    }
                    completionHandler(pod)
                    return
                }
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
                completionHandler(nil)
                return
            }
        }
    }
}

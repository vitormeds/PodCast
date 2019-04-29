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
    
    static let header = ["X-ListenAPI-Key" : "b8fc388d34c24d17ac2196341809e06f"]
    
    static func getGenres(completionHandler: @escaping ([Genre]?) -> ()) {
       
        let url = "https://listen-api.listennotes.com/api/v2/genres"
        
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
        
        let url = "https://listen-api.listennotes.com/api/v2/best_podcasts?genre_id=" + "\(genres[genresPods].id!)"
        
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
        
        let url = "https://listen-api.listennotes.com/api/v2/episodes/" + id
        
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
    
    static func getPodCastListById(id: String, next: String? = "",completionHandler: @escaping (PodCastList?) -> ()) {
        
        var url = "https://listen-api.listennotes.com/api/v2/podcasts/" + id
        if next != "" {
            url = url + "?next_episode_pub_date=" + next!
        }
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            
            if let err = response.error {
                print("Failed to read", err)
                completionHandler(nil)
                return
            }
            
            guard let data = response.data else { return }
            
            do {
                if !data.isEmpty {
                    let pod = try JSONDecoder().decode(PodCastList.self, from: data)
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

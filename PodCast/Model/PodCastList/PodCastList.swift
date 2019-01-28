//
//  PodCastList.swift
//  PodCast
//
//  Created by Vitor Mendes on 28/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct PodCastList: Decodable {
    let next_episode_pub_date: Int?
    let website: String?
    let title: String?
    let listennotes_url: String?
    let thumbnail: String?
    let episodes: [Podcast]?
    let is_claimed: Bool?
    let language: String?
    let rss: String?
    let itunes_id: Int?
    let earliest_pub_date_ms: Int?
    let id: String?
    let description: String?
    let country: String?
    let email: String?
    let image: String?
    let explicit_content: Bool?
    let publisher: String?
    let extra: Extra?
    let lastest_pub_date_ms: Int?
    let genres: [String]?
    let total_episodes: Int?
    let looking_for: LookingFor?
}


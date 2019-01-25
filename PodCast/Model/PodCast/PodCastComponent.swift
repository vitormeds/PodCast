//
//  PodCastComponent.swift
//  PodCast
//
//  Created by Vitor Mendes on 25/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct PodCastComponent: Decodable {
    let total_episodes: Int?
    let language: String?
    let image: String?
    let is_claimed: Bool?
    let email: String?
    let itunes_id: Int?
    let title: String?
    let website: String?
    let publisher: String?
    let extra: Extra?
    let earliest_pub_date_ms: Int?
    let genres: [String]?
    let description: String?
    let explicit_content: Bool?
    let rss: String?
    let lastest_pub_date_ms: Int?
    let id: String?
    let thumbnail: String?
    let listennotes_url: String?
    let looking_for: LookingFor?
    let country: String?
}

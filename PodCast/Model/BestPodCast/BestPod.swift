//
//  BestPod.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct BestPod: Decodable {
    let itunes_id: Int?
    let extra: Extra?
    let country: String?
    let language: String?
    let is_claimed: Bool?
    let explicit_content: Bool?
    let email: String?
    let website: String?
    let publisher: String?
    let earliest_pub_date_ms: Int?
    let description: String?
    let looking_for: LookingFor?
    let thumbnail: String?
    let image: String?
    let listennotes_url: String?
    let title: String?
    let total_episodes: Int?
    let rss: String?
    let lastest_pub_date_ms: Int?
    let id: String?
}

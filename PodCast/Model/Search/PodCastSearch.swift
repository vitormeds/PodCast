//
//  PodCastSearch.swift
//  PodCast
//
//  Created by Vitor Mendes on 19/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct PodCastSearch: Decodable {
    let lastest_pub_date_ms:  Int?
    let description_highlighted: String?
    let itunes_id: Int?
    let publisher_original: String?
    let earliest_pub_date_ms: Int?
    let genres: [Int]?
    let description_original: String?
    let title_highlighted: String?
    let email: String?
    let rss: String?
    let thumbnail: String?
    let title_original: String?
    let image: String?
    let explicit_content: Bool?
    let id: String?
    let total_episodes: Int?
    let listennotes_url: String?
    let publisher_highlighted: String?
}

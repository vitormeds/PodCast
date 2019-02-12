//
//  PodCastSearch.swift
//  PodCast
//
//  Created by Vitor Mendes on 12/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct PodCastSearch: Decodable {
    let pub_date_ms:  Int?
    let publisher_original: String?
    let title_highlighted: String?
    let description_original: String?
    let audio_length: String?
    let rss: String?
    let image: String?
    let podcast_listennotes_url: String?
    let title_original: String?
    let thumbnail: String?
    let explicit_content: Bool?
    let audio: String?
    let podcast_title_original: String?
    let id: String?
    let description_highlighted: String?
    let itunes_id: Int?
    let genres: [Int]?
    let podcast_title_highlighted: String?
    let podcast_id: String?
    let transcripts_highlighted: [String]?
    let publisher_highlighted: String?
    let listennotes_url: String?
}

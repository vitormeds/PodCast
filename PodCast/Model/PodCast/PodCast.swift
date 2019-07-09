//
//  PodCast.swift
//  PodCast
//
//  Created by Vitor Mendes on 25/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct Podcast: Decodable {
    let audio_length: Int?
    let image: String?
    let title: String?
    let listennotes_edit_url: String?
    let explicit_content: Bool?
    let audio: String?
    let pub_date_ms: Int?
    let podcast: PodCastComponent?
    let description: String?
    let id: String?
    let thumbnail: String?
    let listennotes_url: String?
    let maybe_audio_invalid: Bool?
    let isDownload: Bool?
}


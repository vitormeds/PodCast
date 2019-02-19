//
//  PodCastSearchList.swift
//  PodCast
//
//  Created by Vitor Mendes on 12/02/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct EpisodeSearchList: Decodable {
    let next_offset: Int?
    let results: [EpisodeSearch]?
    let took: Double?
    let total: Int?
    let count: Int?
}

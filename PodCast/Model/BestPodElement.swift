//
//  BestPodElement.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct BestPodElement: Decodable {
    let total: Int
    let name: String
    let previous_page_number: Int
    let channels: [BestPod]
    let has_next: Bool
    let listennotes_url: String
    let page_number: Int
    let parent_id: Int
    let next_page_number: Int
    let id: Int
    let has_previous: Bool
}

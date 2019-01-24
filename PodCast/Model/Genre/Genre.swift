//
//  Genre.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct Genre: Decodable {
    let parent_id: Int?
    let name: String?
    let id: Int?
}

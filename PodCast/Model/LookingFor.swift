//
//  LookFor.swift
//  PodCast
//
//  Created by Vitor Mendes on 22/01/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

struct LookingFor: Decodable {
    let sponsors: Bool?
    let cohosts: Bool?
    let guests: Bool?
    let cross_promotion: Bool?
}

//
//  Ad.swift
//  PodCast
//
//  Created by Vitor on 30/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

class Ad {
    
    static var isPremium = false
    static var adBannerTest = ""
    static var adBannerHome = isPremium ? adBannerTest:"ca-app-pub-2452939732701073/6992162454"
    static var adBannerConfig = isPremium ? adBannerTest:"ca-app-pub-2452939732701073/9570224334"
    static var adBannerMyPods = isPremium ? adBannerTest:"ca-app-pub-2452939732701073/2861345754"
    static var adBannerPlayer = isPremium ? adBannerTest:"ca-app-pub-2452939732701073/4856953704"
    static var adBannerListPods = isPremium ? adBannerTest:"ca-app-pub-2452939732701073/5528420438"
}

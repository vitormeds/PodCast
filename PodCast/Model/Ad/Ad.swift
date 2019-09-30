//
//  Ad.swift
//  PodCast
//
//  Created by Vitor on 30/09/19.
//  Copyright © 2019 Vitor Mendes. All rights reserved.
//

import Foundation

class Ad {
    
    static var isDebug = false
    static var adBannerTest = "ca-app-pub-3940256099942544/2934735716"
    static var adBannerHome = isDebug ? adBannerTest:"ca-app-pub-2452939732701073/6992162454"
    static var adBannerConfig = isDebug ? adBannerTest:"ca-app-pub-2452939732701073/9570224334"
    static var adBannerMyPods = isDebug ? adBannerTest:"ca-app-pub-2452939732701073/2861345754"
    static var adBannerPlayer = isDebug ? adBannerTest:"ca-app-pub-2452939732701073/4856953704"
    static var adBannerListPods = isDebug ? adBannerTest:"ca-app-pub-2452939732701073/5528420438"
}

//
//  CommunityDataList.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import Foundation

struct CommunityDataList: Codable {
    static var shared = CommunityDataList(communities: [])
    var communities: [CommunityData.CommunityDataDetail]
    init(communities: [CommunityData.CommunityDataDetail]) {
        self.communities = communities
    }
}

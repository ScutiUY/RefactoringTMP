//
//  CommunityData.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import Foundation

struct CommunityData : Codable {
    static var shared = CommunityData(resCode: "", resMsg: "", data: [])
    let resCode: String
    let resMsg: String
    let data: [CommunityDataDetail]
    init(resCode: String, resMsg: String, data: [CommunityDataDetail]) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
    struct CommunityDataDetail: Codable {
        static var shared = CommunityDataDetail(imgUrl: "", title: "", tags: "", theme: "", idx: 0)
        let imgUrl: String
        let title: String
        let tags: String
        let theme: String
        let idx: Int
        init(imgUrl: String, title: String, tags: String, theme: String, idx: Int) {
            self.imgUrl = imgUrl
            self.title = title
            self.tags = tags
            self.theme = theme
            self.idx = idx
        }
    }
}

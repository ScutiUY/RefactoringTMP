//
//  ReviewData.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import Foundation

struct ReviewData: Codable {

    static var shared = ReviewData(title: "", startDate: "", endDate: "", content: "", tags: "", theme: "", shopList: [])

    var title: String
    var startDate: String
    var endDate: String
    var content: String
    var tags: String
    var theme: String
    var shopList: [ShopListDetail]
    init(title: String, startDate: String, endDate: String, content: String, tags: String, theme: String, shopList: [ShopListDetail]) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.content = content
        self.tags = tags
        self.theme = theme
        self.shopList = shopList
    }
    struct ShopListDetail: Codable {
        static var shared = ShopListDetail(sIdx: "", vDate: "")

        var sIdx: String
        var vDate: String
        init(sIdx: String, vDate: String) {
            self.sIdx = sIdx
            self.vDate = vDate
        }
    }
}

struct ReviewResponseData: Codable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resCode = try values.decode(String.self, forKey: .resCode)
        resMsg = try values.decode(String.self, forKey: .resMsg)
        data = try? values.decode(String.self, forKey: .data)
    }
    
    var resCode : String
    var resMsg : String
    var data : String?
    
    enum CodingKeys: CodingKey {
        case resCode, resMsg, data
    }
}


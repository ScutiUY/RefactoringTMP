//
//  JourneyDetailData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

struct DestinationDetailData: Codable {
    static var shared = DestinationDetailData(resCode: "", resMsg: "", data: DestinationData.shared)
    let resCode: String
    let resMsg: String
    let data: DestinationData
    init(resCode: String, resMsg: String, data: DestinationData) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
    
}
struct DestinationData: Codable {
    static var shared = DestinationData(imgUrl: "", address: "", name: "", idx: "", content: "", category: "", images: [])
    let imgUrl: String
    let address: String
    let name: String
    let category: String
    let idx: String
    let content: String
    let images: [String]
    init(imgUrl: String, address: String, name: String, idx: String, content: String, category: String, images: [String]) {
        self.imgUrl = imgUrl
        self.address = address
        self.name = name
        self.idx = idx
        self.content = content
        self.category = category
        self.images = images
    }
}


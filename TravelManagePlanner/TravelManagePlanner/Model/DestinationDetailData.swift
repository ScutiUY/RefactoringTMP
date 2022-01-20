//
//  JourneyDetailData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

struct DestinationDetailData: Codable {
    
    static var shared = DestinationDetailData(idx: "", name: "", address: "", imgUrl: [], content: "")
    
    var idx: String
    var name: String
    var address: String
    var imgUrl: [String]
    var content: String
    
    init(idx: String, name: String, address: String, imgUrl: [String], content: String) {
        self.idx = idx
        self.name = name
        self.address = address
        self.imgUrl = imgUrl
        self.content = content
    }
}

struct DestinationDetailImage: Codable {
    static var shared = DestinationDetailImage(title: "", link: "")
    let title: String
    let link: String
}

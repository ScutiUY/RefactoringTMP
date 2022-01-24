//
//  JourneyDetailData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

struct DestinationDetailData: Codable {
    let resCode: String
    let resMsg: String
    let data: String
    init(resCode: String, resMsg: String, data: String) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
    struct DestinationData: Codable {
        static var shared = DestinationData(imgUrl: "", address: "", name: "", idx: "", content: "")
        let imgUrl: String
        let address: String
        let name: String
        let idx: String
        let content: String
        init(imgUrl: String, address: String, name: String, idx: String, content: String) {
            self.imgUrl = imgUrl
            self.address = address
            self.name = name
            self.idx = idx
            self.content = content
        }
    }
}



struct DestinationDetailImage: Codable {
    static var shared = DestinationDetailImage(title: "", link: "")
    let title: String
    let link: String
}

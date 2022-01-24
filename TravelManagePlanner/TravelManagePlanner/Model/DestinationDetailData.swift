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
    let data: [DestinationData]
    
    struct DestinationData: Codable {
        static var shared = DestinationData(imgUrl: "", address: "", name: "", idx: "", content: "")
        let imgUrl: String
        let address: String
        let name: String
        let idx: String
        let content: String
    }
}



struct DestinationDetailImage: Codable {
    static var shared = DestinationDetailImage(title: "", link: "")
    let title: String
    let link: String
}

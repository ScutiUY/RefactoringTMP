//
//  JourneyDetail.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/25.
//

import Foundation

struct JourneyDetail: Codable {
    
    static var shared = JourneyDetail(resCode: "", resMsg: "", data: [])
    
    var resCode: String
    var resMsg: String
    var data: [JourneyDetailData]
    
    init(resCode: String, resMsg: String, data: [JourneyDetailData]) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
}

struct JourneyDetailData: Codable {
    
    static var shared = JourneyDetailData(imgUrl: "", name: "", idx: 0, category: "", content: "", sIdx: 0, leaveData: "", address: "", visitDate: "")
    
    let idx: Int
    let category: String
    let imgUrl: String
    let name: String
    let address: String
    let leaveDate: String
    let content: String
    let sIdx: Int
    let visitDate: String
    
    init(imgUrl: String, name: String, idx: Int, category: String, content: String, sIdx: Int, leaveData: String, address: String, visitDate: String) {
        self.imgUrl = imgUrl
        self.name = name
        self.idx = idx
        self.category = category
        self.content = content
        self.sIdx = sIdx
        self.leaveDate = leaveData
        self.address = address
        self.visitDate = visitDate
        
    }
}

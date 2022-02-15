//
//  DestiData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/10.
//
import Foundation

// 목적지 설정 Request
struct DestiSearchRequest: Codable {
    static var shared = DestiSearchRequest(place: "")
    var place: String
    
    var filterValue: Array<String> = []
    var placeData: Array<String> = ["서울", "경기도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도"]

    init(place: String) {
        self.place = place
    }
}

// 목적지 응답
struct DestiSearchResponse: Codable {
    static var shared = DestiSearchResponse(resCode: "", resMsg: "", data: [])
    
    var resCode: String
    var resMsg: String
    var data: [DestiSearchResponseData]
    
    init (resCode: String, resMsg: String, data: [DestiSearchResponseData]) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
}

// 목적지 응답 데이터 구조체
struct DestiSearchResponseData: Codable {
    
    static var shared = DestiSearchResponseData(area: "", imgUrl: "", address: "", name: "", idx: 0, category: "", content: "")
    
    let area: String
    let imgUrl: String
    let address: String
    let name: String
    let idx: Int
    let category: String
    let content: String
    
    init(area: String, imgUrl: String, address: String, name: String, idx: Int, category: String, content: String) {
        
        self.area = area
        self.imgUrl = imgUrl
        self.address = address
        self.name = name
        self.idx = idx
        self.category = category
        self.content = content
    }
    
}

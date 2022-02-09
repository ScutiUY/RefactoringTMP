//
//  DestiData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/10.
//
import Foundation

// 목적지 설정
struct DestiSearchData: Codable {
    static var shared = DestiSearchData(place: "")
    var place: String
    
    var filterValue: Array<String> = []
    var placeData: Array<String> = ["서울", "경기도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도"]

    init(place: String) {
        self.place = place
    }
}

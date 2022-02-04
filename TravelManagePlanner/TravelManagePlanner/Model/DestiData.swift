

//
//  DestiData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/10.
//
import Foundation

// 목적지
struct DestiSearchData: Codable {
    static let shared = DestiSearchData(place: "")
    let place: String
    var filterValue: Array<String> = []
    let placeData: Array<String> = ["강남", "강기도", "강원도", "서울시", "서강시"]

    init(place: String) {
        self.place = place
    }
}

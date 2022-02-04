

//
//  DestiData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/01/10.
//
import Foundation

// 싱글톤 패턴 목적지 모델
struct DestiSearchResponse: Codable {
    static let shared = DestiSearchResponse(place: "")
    let place: String
    
    var filterValue: Array<String> = []
    let placeData: Array<String> = ["강남", "강기도", "강원도", "서울시", "서강시"]
    
    // 여러개의 인스턴스 생성을 방지하고자 private선어
     init(place: String) {
        self.place = place
    }
}

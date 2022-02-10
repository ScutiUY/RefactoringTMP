//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct JourneyList: Codable {
    static var shared = JourneyList(resCode: "", resMsg: "", jorneys: [])
    var resCode: String
    var resMsg: String
    let data: [Journey]
    init(resCode: String, resMsg: String, jorneys: [Journey]) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = jorneys
    }
    enum Codingkeys: String, CodingKey {
        case resCode
        case resMsg
        case data = "data"
    }
}

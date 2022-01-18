//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct JourneyList: Codable {
    static var shared = JourneyList(title: "", desc: "", jorneys: [])
    let title: String
    let desc: String
    let journeys: [Journey]
    init(title: String, desc: String, jorneys: [Journey]) {
        self.title = title
        self.desc = desc
        self.journeys = jorneys
    }
}




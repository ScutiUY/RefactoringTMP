//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct JourneyList: Codable {
    static var shared = JourneyList(jorneys: [])
    let journeys: [Journey]
    init(jorneys: [Journey]) {
        self.journeys = jorneys
    }
}




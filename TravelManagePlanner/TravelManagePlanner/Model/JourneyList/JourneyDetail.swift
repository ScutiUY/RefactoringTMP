//
//  JourneyDetail.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/25.
//

import Foundation

struct JourneyDetail: Codable {
    let thumnailUrl: String
    let name: String
    let desc: String
    let date: String
    let tag: String

}
enum ContentType {
    case accommodation
    case restaurant
    case attraction
}

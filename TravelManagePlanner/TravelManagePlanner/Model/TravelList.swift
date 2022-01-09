//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct TravelList: Codable {
    static var shared = TravelList(title: "", desc: "", travels: [])
    let title: String?
    let desc: String?
    let travels: [Travel]
    init(title: String, desc: String, travels: [Travel]) {
        self.title = title
        self.desc = desc
    }
}


enum ContentType {
    case accommodation
    case restaurant
    case attraction
}

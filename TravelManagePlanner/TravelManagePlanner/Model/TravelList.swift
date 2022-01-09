//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct UserData: Codable {
    static var shared = UserData(userId: "", userPw: "", name: "")
    let userId: String?
    let userPw: String?
    let name: String?
}

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

struct Travel: Codable {
    
    static var shared = Travel(type: .accommodation, name: "", desc: "", image: "")
    
    let type: ContentType
    let name: String
    let desc: String
    let image: String
    
    init(type: ContentType, name: String, desc: String, image: String) {
        self.type = type
        self.name = name
        self.desc = desc
        self.image = image
    }
}

enum ContentType {
    case accommodation
    case restaurant
    case attraction
}

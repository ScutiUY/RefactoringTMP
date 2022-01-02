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

struct TravelData: Codable {
    static var shared = TravelData(title: "", desc: "")
    let title: String?
    let desc: String?
}

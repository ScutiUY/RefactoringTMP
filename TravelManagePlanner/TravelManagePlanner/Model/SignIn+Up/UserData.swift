//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct UserData: Codable {
    static var shared = UserData(nickname: "", pw: "", userKey: "")
    
    private init(nickname: String, pw: String, userKey: String) {
        self.userpw = pw
        self.nickname = nickname
        self.userKey = userKey
    }
    
    var userpw: String
    var nickname: String
    var userKey: String
    
    enum CodingKeys : String, CodingKey {
        case userpw = "user_pw"
        case nickname
        case userKey
    }
}



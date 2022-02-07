//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct UserData: Codable {
    static var shared = UserData(email: "", pw: "", name: "")
    init(email: String, pw: String, name: String) {
        self.userEmail = email
        self.userPw = pw
        self.name = name
    }
    var userEmail: String
    var userPw: String
    var name: String
}

struct LoginData: Codable {
    static var shared = LoginData(email: "", pw: "")
    init(email: String, pw: String) {
        self.email = email
        self.password = pw
    }
    var email: String
    var password: String
}

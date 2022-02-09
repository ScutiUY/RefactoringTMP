//
//  Data.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation

struct LoginData: Codable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resCode = try values.decode(String.self, forKey: .resCode)
        resMsg = try values.decode(String.self, forKey: .resMsg)
        data = try? values.decode(UserData.self, forKey: .data)
    }
    
    var resCode: String
    var resMsg: String
    var data: UserData?
    
    enum CodingKeys: CodingKey {
        case resCode, resMsg, data
    }
}

struct UserData: Codable {
    static var shared = UserData(nickname: "", pw: "", userKey: "")
    
    init(nickname: String, pw: String, userKey: String) {
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



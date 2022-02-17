//
//  PersonalDataResponseData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import Foundation

struct PersonalDataResponseData: Codable {
    
    var resCode: String
    var resMsg: String
    var data: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resCode = try values.decode(String.self, forKey: .resCode)
        resMsg = try values.decode(String.self, forKey: .resMsg)
        data = try? values.decode(String.self, forKey: .data)
    }
}

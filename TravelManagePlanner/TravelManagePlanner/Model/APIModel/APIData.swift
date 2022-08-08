//
//  APIData.swift
//  TravelManagePlanner
//
//  Created by 신의연 on 2022/08/08.
//

import Foundation

struct TemplateModel<T: Codable>: Codable {
    var resCode: String
    var resMsg: String
    var data: T?
    
    enum CodingKeys: CodingKey {
        case resCode, resMsg, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resCode = try values.decode(String.self, forKey: .resCode)
        resMsg = try values.decode(String.self, forKey: .resMsg)
        data = try? values.decode(T.self, forKey: .data)
    }
}

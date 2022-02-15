//
//  SettingsResponseData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import Foundation


struct SettingsResponseData: Codable {
    
    var resCode: String
    var resMsg: String
    var data: VersionInfo
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resCode = try values.decode(String.self, forKey: .resCode)
        resMsg = try values.decode(String.self, forKey: .resMsg)
        data = try values.decode(VersionInfo.self, forKey: .data)
    }
    
    struct VersionInfo: Codable {
        
        var versionName: String
        
        init(versionName: String) {
            self.versionName = versionName
        }
    }
}

//
//  APIDataModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/13.
//

import Foundation
import UIKit

struct JourneyListResData {
    static var shared = JourneyListResData(resCode: "", resMsg: "", data: "")
    var resCode: String
    var resMsg: String
    var data: String
    init(resCode: String, resMsg: String, data: String) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
}

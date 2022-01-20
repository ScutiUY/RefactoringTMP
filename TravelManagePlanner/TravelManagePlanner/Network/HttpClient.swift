//
//  HttpClient.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/20.
//

import Foundation
import Alamofire

class HttpClient {
    private let baseUrl: String
    private let headerDic: [String: String] = ["appCode": "TMP_iOS"]
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getJson(path: String, params: [String: String] = [:], completed: @escaping (Result<String, AFError>) -> Void) {
        let fullPath = self.baseUrl + path
        
        AF.request(fullPath, method: .post, parameters: params, headers: HTTPHeaders(headerDic)).validate().responseString { response in
            completed(response.result)
        }
    }
}

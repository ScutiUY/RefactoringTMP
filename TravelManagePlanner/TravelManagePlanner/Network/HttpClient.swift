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
    
    func getJson(path: String, params: [String: String] = [:], completed: @escaping (Result<Data, AFError>) -> Void) { // path 통해서 세부 url 받아옴, params로 바디 파라미터 받아옴
        //let fullPath = self.baseUrl + path
        let fullPath = "https://scutiuy.github.io/testWebHosting/Detail.json" // 테스트용 url
//        AF.request(fullPath, method: .post, parameters: params, headers: HTTPHeaders(headerDic)).validate().responseString { response in
//            if response.data == nil {
//                completed(Result.failure(response.error!))
//            } else {
//                completed(Result.success(response.data!))
//            }
//        }
        AF.request(fullPath, method: .get).validate().responseString { response in
            if response.data == nil {
                completed(Result.failure(response.error!))
            } else {
                completed(Result.success(response.data!))
            }
        }
    }
}

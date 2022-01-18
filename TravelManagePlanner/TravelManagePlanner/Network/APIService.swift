//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation
import Alamofire

import Foundation
import Alamofire
import UIKit

enum APIError: Int, Error {
    case unknown = -1
    case jsonError = -2
    case invalidArgument = -3
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
}

struct APIRequest {
    static let url: String = "https://eunryuplaners.com:19624"
    
    /// - Post
    func getJourneyList(completed: @escaping (Result<String, Error>) -> Void) {
        let url = "https://eunryuplaners.com:19624/mmb/checkLogin.tpi"
        var request = URLRequest(url: URL(string: url)!)
        let header = ["appCode": "TMP_iOS"]
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        
        let params: [String: String] = ["":""]
        let method = HTTPMethod(rawValue: "POST")
        // httpBody 에 parameters 추가
        
        AF.request(url, method: method, parameters: params, headers: HTTPHeaders(header)).responseString { (response) in
            switch response.result {
            case .success:
                print(response.result)
                print("POST 성공")
                let re = String(data: response.data!, encoding: .utf16)
                completed(Result.success(re!))
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                completed(Result.failure(error))
            }
        }
    }
}

//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation
import Alamofire

enum APIError: Int, Error {
    case unknown = -1
    case jsonError = -2
    case invalidArgument = -3
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
}

struct APIRequest {
    static let url: String = "http://cutely93.cafe24.com:19624/mmb/joinMember.tpi"
    
    /// - GET
    func getJson(error: APIError? = nil, completion: @escaping (UserData) -> Void) {
        
        AF.request(APIRequest.url, method: .get, headers: nil).validate(statusCode: 0..<300).responseJSON { response in
            print(response)
        }
    }
    
    /// - Post
    func postData() {
        AF.request(APIRequest.url, method: .post, parameters: nil).validate(statusCode: 0..<400).responseJSON { response in
            print(response)
        }
    }
}

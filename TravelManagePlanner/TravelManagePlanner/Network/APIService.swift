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
    static let url: String = "https://eunryuplaners.com:19624"
    static let headerDic: [String: String] = ["appCode": "TMP_iOS"]
    
    
    /// - Post
    func getJourneyDetailImage(completion: @escaping (DestinationDetailData) -> Void) {
        let destinationDataURL = "/plan/getAllShopList.tpi" // 임시
        
        AF.request(APIRequest.url + destinationDataURL, method: .post, headers: HTTPHeaders(APIRequest.headerDic)).validate().responseString { response in
            print("",response.result)
            
        }
    }
}

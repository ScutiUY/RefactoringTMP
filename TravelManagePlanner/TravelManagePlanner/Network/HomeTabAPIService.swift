//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation
import Alamofire
import UIKit


// Encoding, Decoding하여 Repository에 담은 데이터를 AF를 통하여 전송
struct HomeTapAPIRequest {
    
    static let url: String = "https://eunryuplaners.com:19624"
    static let headerDic: [String: String] = ["appCode": "TMP_iOS"]
    
    // 전달받은 json데이터를 인자로 담아서 테마 데이터 전송 (서버쪽에서 평문으로 받을것인지 논의 필요)
    func setThemeData(homeTabData: HomeTabData, completed: @escaping (Result<String, Error>) -> Void) {
        
        let ThemeDataURL = "/plan/getAllShopList.tpi" // 추후 변경필요
        let params: [String : String] = ["themeData":"\(homeTabData.themeData)"]
        
        AF.request(
            APIRequest.url + ThemeDataURL,
            method: .post,
            parameters: params,
            headers: HTTPHeaders(APIRequest.headerDic)).validate().responseString { response in
            
            // 통신결과(AF에서 제공)
            switch response.result {
                case .success:
                    print("AF 통신성공!", response.result)
                    
                case .failure:
                    print("AF 통신에러! : ", response.result)
                }
        }
    }
        
        // 숙박업소 추천지 get
        func getAccomoData() {
            
        }
        
        // 맛집 추천지 get
        func getRestaurantData() {
            
        }
        
        // 놀거리 추천지 get
        func getEntertainData() {
            
        }
    
    
}

// API 통신에러에 대한 정의
extension HomeTapAPIRequest {
    enum HomeTapAPIError: Int, Error {
        case unknown = -1
        case jsonError = -2
        case invalidArgument = -3
        case badRequest = 400
        case notFound = 404
        case internalServerError = 500
        
    }
}

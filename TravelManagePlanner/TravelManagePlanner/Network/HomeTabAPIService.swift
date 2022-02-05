//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation
import Alamofire
import UIKit

enum HomeTapAPIError: Int, Error {
    case unknown = -1
    case jsonError = -2
    case invalidArgument = -3
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
}

struct HomeTapAPIRequest {
    static let url: String = "https://eunryuplaners.com:19624"
    static let headerDic: [String: String] = ["appCode": "TMP_iOS"]
    // - Post
    
    // 
    
    
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


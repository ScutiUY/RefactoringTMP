//
//  TMPEndPoint.swift
//  TravelManagePlanner
//
//  Created by 신의연 on 2022/08/03.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIEndpoint {
    case signIn(id: String, password: String)
    case signUp(id: String, password: String,_ name: String)
    case journeyList(userKey: String)
    case journeyDetail(travelID: String)
}

extension APIEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: URLManager.Base.baseURL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .journeyList:
            return .post
        case .journeyDetail:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return URLManager.Member.login
        case .signUp:
            return URLManager.Member.joinMember
        case .journeyList:
            return URLManager.Plan.getMyTravelList
        case .journeyDetail:
            return URLManager.Plan.getTravelDetailinfo
        }
    }
    
    var headers: HTTPHeaders {
        return ["appCode": "TMP_iOS"]
    }
    
    var parameters: Parameters? {
        switch self {
        case .signIn(let id, let pw):
            return ["loginId": id, "loginPw": pw]
        case .signUp(let id, let pw, _):
            return ["loginId": id, "loginPw": pw]
        case .journeyList(let userKey):
            return ["uKey": userKey]
        case .journeyDetail(let travelID):
            return ["travelId": travelID]
        }
    }
 
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(self.path))
        urlRequest.method = self.method
        urlRequest.headers = self.headers
        
        let encoding = URLEncoding.default
        return try encoding.encode(urlRequest, with: self.parameters)
    }
}

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
    func login(loginData: LoginData) {
        let url = "https://eunryuplaners.com:19624/mmb/checkLogin.tpi"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "appCode - TMP_iOS")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params: [String: String] = ["loginid":"\(loginData.email)", "loginPw":"\(loginData.password)"]
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print(response.value)
                print(response.data)
                print(response.result)
                print("POST 성공")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
    func signUp(userData: UserData) {
        
    }
    
}

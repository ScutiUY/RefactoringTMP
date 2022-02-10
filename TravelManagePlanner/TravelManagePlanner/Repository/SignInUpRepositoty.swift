//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

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
    case omittedParams = 9992
    case ommittedHeader = 4444
    case notFoundInDB = 3001
    case invalidPw = 4001
}

struct SignInUpRepository {
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
    func login(inputId: String, inputPw: String, completed: @escaping (Result<LoginData, APIError>) -> Void) {
        let path = URLManager.Member.login
        let params: [String: String] = ["loginId":"\(inputId)", "loginPw":"\(inputPw)"]
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(LoginData.self, from: data)
                    
                    switch decodedData.resCode {
                    case "9992":
                        completed(.failure(.omittedParams))
                    case "4444":
                        completed(.failure(.ommittedHeader))
                    case "3001":
                        completed(.failure(.notFoundInDB))
                    case "4001":
                        completed(.failure(.invalidPw))
                    default:
                        completed(.success(decodedData))
                    }
                } catch {
                    #if DEBUG
                    print(error.localizedDescription, #function)
                    #endif
                }
                
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                completed(Result.failure(APIError.jsonError))
            }
        }
    }
    
    func signUp(inputEmail: String, inputPw: String, inputName: String, completed: @escaping (Result<String, APIError>) -> Void) {
        let path = URLManager.Member.joinMember
        let params: [String: String] = ["userId":"\(inputEmail)", "userPw":"\(inputPw)", "name":"\(inputName)"]
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
                
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(LoginData.self, from: data)
                    
                    switch decodedData.resCode {
                    case "9992":
                        completed(.failure(.omittedParams))
                    case "4444":
                        completed(.failure(.ommittedHeader))
                    case "3001":
                        completed(.failure(.notFoundInDB))
                    case "4001":
                        completed(.failure(.invalidPw))
                    default:
                        completed(.success(decodedData.resMsg))
                    }
                    
                } catch {
                    #if DEBUG
                    print(error.localizedDescription, #function)
                    #endif
                }
                
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                completed(.failure(.jsonError))
            }
        }
    }
}


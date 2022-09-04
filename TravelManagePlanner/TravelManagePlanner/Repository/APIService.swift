//
//  APIService.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/26.
//

import Foundation
import Alamofire

struct APIService {
    private let httpClient = HttpClient()
    
    func requestData<T: Codable> (
        endPoint: APIEndpoint,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>)
        -> Void
    ) {
        httpClient.request(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(TemplateModel<T>.self, from: data)
                    switch decodedData.resCode {
                    case "9992":
                        completion(.failure(APIError.omittedParams))
                    case "4444":
                        completion(.failure(APIError.ommittedHeader))
                    case "3001":
                        completion(.failure(APIError.notFoundInDB))
                    case "4001":
                        completion(.failure(APIError.invalidPw))
                    case "0000":
                        guard let data = decodedData.data else {
                            completion(.failure(NetworkError.emptyData))
                            return
                        }
                        completion(.success(data))
                    default:
                        completion(.failure(APIError.unknownError))
                    }
                    
                } catch {
                    #if DEBUG
                    print(error.localizedDescription, #function)
                    #endif
                    completion(.failure(NetworkError.decodeError))
                }
            case .failure(let error):
                completion(.failure(error as! NetworkError))
            }
        }
        
    }
}


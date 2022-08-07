//
//  HttpClient.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/20.
//

import Foundation
import Alamofire

struct HttpClient {
    
    func request(endPoint: TargetType, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let request = try endPoint.asURLRequest()
            
            AF.request(request).responseJSON { responseData in
                if let error = responseData.error {
                    completion(.failure(NetworkError.requestFail(error)))
                }
                guard let response = responseData.response else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                guard 200..<299 ~= response.statusCode else {
                    completion(.failure(NetworkError.failedResponse(statusCode: response.statusCode)))
                    return
                }
                guard let data = responseData.data else {
                    completion(.failure(NetworkError.emptyData))
                    return
                }
                completion(.success(data))
            }
        } catch let requestError {
            completion(.failure(NetworkError.requestFail(requestError)))
        }
        
        
    }
    
}

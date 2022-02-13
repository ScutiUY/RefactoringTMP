//
//  Repositories.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/20.
//

import Foundation
import Alamofire

class DestinationInfoRepositories: NSObject {
    
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
    func getDestinationDetailInfo(shopID: String, completed: @escaping (DestinationData) -> Void) {
        
        let path = URLManager.Plan.getTravelDetailinfo
        let params = ["shopId": shopID]
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(DestinationDetailData.self, from: data)
                    switch decodedData.resCode {
                    case "9992":
                        print(#function, APIError.omittedParams)
                    case "4444":
                        print(#function, APIError.ommittedHeader)
                    case "3001":
                        print(#function, APIError.notFoundInDB)
                    case "4001":
                        print(#function, APIError.invalidPw)
                    default:
                        completed(decodedData.data)
                    }
                    
                } catch let error as DecodingError {
                    
                    #if DEBUG
                    print("Decoidng \(error) in \(#function)")
                    #endif
                    
                }catch {
                    
                    #if DEBUG
                    print("known error in \(#function)")
                    #endif
                    
                }
                
            case .failure(_):
                #if DEBUG
                print("getJson error in \(#function)")
                #endif
            }
            
        }
    }
    
}

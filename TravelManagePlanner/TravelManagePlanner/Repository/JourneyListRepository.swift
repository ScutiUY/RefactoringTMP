//
//  JourneyListRepository.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/25.
//

import Foundation

struct JourneyListRepository {
    
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
    func getJourneyList(completed: @escaping ([Journey]) -> Void) {
        let path = URLManager.Plan.getMyTravelList
        let params = ["uKey": "10000001"]
        // uKey test용임 UserData.shared로 가져와야 함.
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(JourneyList.self, from: data)
                    completed(decodedData.data)
                } catch {
                    #if DEBUG
                    print("getJourneyList Decoidng error in \(#function)")
                    #endif
                }
                
            case .failure(_):
                #if DEBUG
                print("getJourneyList getJsonerro in \(#function) error")
                #endif
            }
            
        }
    }
    
    func getJourneyDetialList(travelId: Int, completed: @escaping (Result<JourneyDetail, APIError>) -> Void) {
        let path = URLManager.Plan.getTravelDetailinfo
        let params = ["travelId": "1"] // test용 id travelId로 바꿔야함
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                
                do {
                    let decodedData = try JSONDecoder().decode(JourneyDetail.self, from: data)
                    print(decodedData)
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
                } catch let error as DecodingError {
                    print(error)
                } catch {
                    print("known error in JourneyReop \(#function)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
       


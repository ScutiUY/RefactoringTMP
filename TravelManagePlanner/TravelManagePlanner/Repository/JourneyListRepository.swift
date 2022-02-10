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
        let path = "/plan/getMyTravelList.tpi"
        let params = ["uKey": "10000001"]
        // uKey test용임 UserData.shared로 가져와야 함.
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                let decodedData = try? JSONDecoder().decode(JourneyList.self, from: data)
                if let journeyData = decodedData {
                    completed(journeyData.data)
                }
                
            case .failure(_):
                break
            }
            
        }
    }
    
    func getJourneyDetialList(travelId: Int, completed: @escaping (Result<JourneyDetail, APIError>) -> Void) {
        let path = "/plan/getTravelDetailInfo.tpi"
        let params = ["travelId": "1"] // test용 id travelId로 바꿔야함
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                let decodedData = try? JSONDecoder().decode(JourneyDetail.self, from: data)
                if let journeyDetailData = decodedData {
                    switch journeyDetailData.resCode {
                        case "9992":
                            completed(.failure(.omittedParams))
                        case "4444":
                            completed(.failure(.ommittedHeader))
                        case "3001":
                            completed(.failure(.notFoundInDB))
                        case "4001":
                            completed(.failure(.invalidPw))
                        default:
                        completed(.success(journeyDetailData))
                        }
                    }
                    
                    
            case .failure(let error):
                print(error)
            }
        }
    }
}
       


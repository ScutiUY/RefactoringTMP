//
//  HomeTabRepository.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/06.
//

import Foundation


// VM을 통해 담았던 model을 decoding, encoding하여 보관
struct HomeTabDataRepository {
    // api 소지
    private let httpClient = HttpClient()
    
    // 목적지 기반 가게 불러오기
    func getPlaceRepository(placeData: DestiSearchRequest,completion: @escaping (Result <DestiSearchResponse, APIError>) -> Void) {
        let path = "/plan/getSearchAreaShopList.tpi"
        let params = ["area":"\(placeData.place)"]
        
//        httpClient.getJsonData(path: path, params: params) { result in
//            switch result {
//            case.success(let data) :
//                do {
//                    let decodedData = try JSONDecoder().decode(DestiSearchResponse.self, from: data)
//                    
//                    switch destiSearchResponseData.resCode {
//                    case "9992":
//                        completion(.failure(.omittedParams))
//                    case "4444":
//                        completion(.failure(.ommittedHeader))
//                    case "3001":
//                        completion(.failure(.notFoundInDB))
//                    case "4001":
//                        completion(.failure(.invalidPw))
//                    default:
//                        completion(.success(destiSearchResponseData))
//                    }
//                } catch {
//                    completion(.failure(NetworkError.decodeError))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    
    // 여행 최종결정
    func setPlanRepository(homeTabRequest: HomeTabRequest, completed: @escaping (HomeTabRequest) -> Void) {

    }
    

}

//
//  HomeTabRepository.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/06.
//

import Foundation


// VM을 통해 담았던 model을 decoding, encoding하여 보관
struct HomeTabRepository {
    // api 소지
    let api = HomeTapAPIRequest()
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
    
    // 목적지 기반 가게 불러오기
    func getPlaceRepository(placeData: DestiSearchRequest,completed: @escaping (Result <DestiSearchResponse, APIError>) -> Void) {
        let path = "/plan/getSearchAreaShopList.tpi"
        let params = ["area":"\(placeData.place)"]
        
        print("getPlaceRepository")
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case.success(let data) :
                let decodedData = try? JSONDecoder().decode(DestiSearchResponse.self, from: data)
               
                if let destiSearchResponseData = decodedData {
                    print("destiSearchResponse :", destiSearchResponseData)
                    switch destiSearchResponseData.resCode {
                    case "9992":
                        completed(.failure(.omittedParams))
                    case "4444":
                        completed(.failure(.ommittedHeader))
                    case "3001":
                        completed(.failure(.notFoundInDB))
                    case "4001":
                        completed(.failure(.invalidPw))
                    default:
                        completed(.success(destiSearchResponseData))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // 여행 최종결정
    func setPlanRepository(homeTabRequest: HomeTabRequest, completed: @escaping (HomeTabRequest) -> Void) {

    }
    

}

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
    
    // 여행 최종결정
    func setPlanRepository(homeTabData: HomeTabData, completed: @escaping (HomeTabData) -> Void) {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(homeTabData)
            print(jsonData)
            
            // API호출하여 josn데이터 전달
            api.setPlanRequest(homeTabData: homeTabData) { result in
                switch result {
                    
                case .success(let themeData) :
                    print("api에 데이터 json전송 성공 : ", themeData)
                    
                case .failure(let error):
                    print("api에 데이터 json전송 실패 : ", error)
                }//switch
            }
            
        } catch {
            print("homeTabData error in homeTabData repository")
        }
    }
    
    // 목적지 기반 가게 불러오기
    func getPlaceRepository(placeData: DestiSearchRequest,completed: @escaping (Result <DestiSearchResponse, APIError>) -> Void) {
        let path = "/plan/getSearchAreaShopList.tpi"
        let params = ["area":"\(placeData.place)"]
        
        print("getPlaceRepository")
        //        do {
        //            api.getPlaceRequest(placeData: placeData) { result in
        //                switch result {
        //                case .success(let responseData) :
        //                    print("api에 목적지 데이터 전송, 응답 성공 : ", responseData)
        //                let decodedData = try? JSONDecoder().decode([DestiSearchResponse].self, from: responseData)
        //
        //                case .failure(let error):
        //                    print("api에 목적지 데이터 전송 실패 : ", error)
        //                }//switch
        //
        //            }
        //        } catch {
        //            print("getPlace error in getPlaceRepository")
        //        }
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case.success(let data) :
                let decodedData = try? JSONDecoder().decode(DestiSearchResponse.self, from: data)
                if let destiSearchResponse = decodedData {
                    switch destiSearchResponse.resCode {
                    case "9992":
                        completed(.failure(.omittedParams))
                    case "4444":
                        completed(.failure(.ommittedHeader))
                    case "3001":
                        completed(.failure(.notFoundInDB))
                    case "4001":
                        completed(.failure(.invalidPw))
                    default:
                        completed(.success(destiSearchResponse))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

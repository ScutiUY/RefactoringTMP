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
    
    //
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
    func getPlaceRepository(placeData: DestiSearchData,completed: @escaping (DestiSearchData) -> Void) {
        
        // encoding
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(placeData)
            print("placeJson: ", jsonData)
            
            // API로 목적지장소 전달
            api.getPlaceRequest(placeData: placeData) { result in
                switch result {
                    
                case .success(let themeData) :
                    print("api에 데이터 json전송 성공 : ", themeData)
                
                case .failure(let error):
                    print("api에 데이터 json전송 실패 : ", error)
                }//switch
                
            }
        } catch {
            print("getPlace error in getPlaceRepository")
        }
        
    }
}

// 오류에 대한 정의
extension HomeTabRepository {
    enum repositoryError: Error {
        case basic
        case error(Error)
        case code(Int)
        
        var msg: String {
            switch self {
                   case .basic:
                       return "DEFAULT Error"
                   case .error(let err):
                       return err.localizedDescription
                   case .code(let code):
                       return "\(code) Error"
                   }
        }
    }
}

//
//  DestiSearchViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/11.
//

import Foundation

class DestiSearchViewModel {
    
    // 목적지 요청 모델 소유
    var destiSearchRequest = DestiSearchRequest(place: "")
    
    // 목적지 응답 모델 소유
    var destiSearchResponse = DestiSearchResponse.shared.data
    
    // repository 소유
    private var repo = HomeTabRepository()
    
    // 유저입력 목적지
    static var serchData = ""
    
    // 상태 정의
    private var isLoading: Bool = false
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    // 목적지 기반 추천지 불러오기
    func getData(){
        self.loadingStarted()
        
        destiSearchRequest.place = DestiSearchViewModel.serchData
        repo.getPlaceRepository(placeData: destiSearchRequest) { result in
            
            switch result {
            case .success(let responseData):
                self.destiSearchResponse = responseData.data
                print("destiSearchResponse!", self.destiSearchResponse)
                print("destiSearchResponseCount", self.destiSearchResponse.count)
                
                self.dataUpdated()
                self.loadingEnded()
            case .failure(let error):
                self.loadingEnded()
                switch error {
                case .notFoundInDB:
                    self.destiSearchResponse = []
                    self.dataUpdated()
                case .unknown:
                    print("알수 없는 오류")
                case .jsonError:
                    print("Json 오류")
                case .invalidArgument:
                    print("매개변수 오류")
                case .badRequest:
                    print("400")
                case .notFound:
                    print("404")
                case .internalServerError:
                    print("repo error")
                case .omittedParams:
                    print("params error")
                case .ommittedHeader:
                    print("header error")
                case .invalidPw:
                    print("Pw error")
                }
            }
        }
    }
    
    func getTitle(idx: Int) -> String {
        return destiSearchResponse[idx].name
    }
    
    func getContent(idx: Int) -> String {
        return destiSearchResponse[idx].content
    }
    
    func getSIdx(idx: Int) -> Int {
        return destiSearchResponse[idx].idx
    }
    
    func getDestiSearchCount() -> Int {
        
        return destiSearchResponse.count
    }
    
    func getShopData(idx: Int, categoryIdx: String) -> DestiSearchResponseData {
        
        //        var shopArray: [DestiSearchResponse]
        //
        //        if destiSearchResponse[idx].category == categoryIdx {
        //            for i in 0..<destiSearchResponse.count{
        //                shopArray += destiSearchResponse[i]
        //            }
        //        }
        return self.destiSearchResponse[idx]
    }
}

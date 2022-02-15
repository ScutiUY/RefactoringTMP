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
    
    // 모델을 static
    
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
#if DEBUG
                print("destiSearchResponse!", self.destiSearchResponse)
                print("destiSearchResponseCount", self.destiSearchResponse.count)
#endif
                
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
    
    func getArea(idx: Int) -> String {
        return destiSearchResponse[idx].area
    }
    
    func getSIdx(idx: Int) -> Int {
        return destiSearchResponse[idx].idx
    }
    
    // 카테고리별 생설될 cell갯수 카운트
    func getDestiSearchCount(categoryIdx: String) -> Int {
        var cnt = 0
        for i in 0..<destiSearchResponse.count {
            if destiSearchResponse[i].category == categoryIdx {
                cnt += 1
            }
        }
        
        return cnt
    }
    
    // 카테고리별 뷰 담아주기
    func getShopData(idx: Int, categoryIdx: String) -> DestiSearchResponseData {
        var filterShopData = DestiSearchResponseData(area: "", imgUrl: "", address: "", name: "", idx: 0, category: "", content: "")
        
            if destiSearchResponse[idx].category == categoryIdx{
               
                filterShopData = destiSearchResponse[idx]
                print("destiSearchResponse[idx]", destiSearchResponse[idx])
        }
        
        return destiSearchResponse[idx]
//        return filterShopData
    }
}

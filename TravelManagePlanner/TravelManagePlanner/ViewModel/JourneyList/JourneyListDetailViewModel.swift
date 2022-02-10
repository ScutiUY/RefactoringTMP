//
//  JourneyListDetailViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

class JourneyListDetailViewModel {
    
    private var journeyDetailList = JourneyDetail.shared.data
    
    private var repo = JourneyListRepository()
    var detailListIdx = 0
    
    private var dateDic = [String: String]()
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func count() -> Int {
        
        print("journeyDetailList.count", journeyDetailList.count)
        return journeyDetailList.count
    }
    func journey(idx: Int) -> JourneyDetailData {
        return journeyDetailList[idx]
    }
    func getData() {
        self.loadingStarted()
        repo.getJourneyDetialList(travelId: detailListIdx) { result in
            switch result {
            case .success(let detailData):
                self.journeyDetailList = detailData.data
                self.dataUpdated()
                self.loadingEnded()
            case .failure(let error):
                self.loadingEnded()
                switch error {
                case .notFoundInDB:
                    self.journeyDetailList = []
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
}

//
//  JourneyListDetailViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

class JourneyListDetailViewModel {
    
    private var journeyDetailList = JourneyDetail.shared.data {
        didSet {
            journeyDetailList.forEach {
                self.dateDic[$0.visitDate] = true
                self.dateDic[$0.leaveDate] = true
            }
            dateArr = dateDic.sorted{ $0.key < $1.key }.map{ $0.key }
        }
    }
    
    private var repo = JourneyListRepository()
    
    var detailListIdx = Int.max
    
    private var dateDic = [String: Bool]()
    private var dateArr = [String]()
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func count() -> Int {
        return journeyDetailList.count
    }
    
    func dateCount() -> Int {
        return dateDic.count
    }
    
    func journey(idx: Int) -> JourneyDetailData {
        return journeyDetailList[idx]
    }
    
    func passJourneyInfoInDate(index: Int) -> [JourneyDetailData] {
        return journeyDetailList.filter{
            if $0.visitDate == dateArr[index] || $0.leaveDate == dateArr[index] {
                return true
            }
            return false
        }
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

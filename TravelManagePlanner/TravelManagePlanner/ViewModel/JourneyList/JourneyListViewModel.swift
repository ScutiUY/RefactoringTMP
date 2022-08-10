//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var api = APIService()
    
    private var journeyList = [Journey]()
    private var isLoading = false
    
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date())
    }
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var journeyListUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func getTitle(idx: Int) -> String {
        return journeyList[idx].title
    }
    
    func journeyListCount() -> Int {
        return journeyList.count
    }
    func journey(index: Int) -> Journey {
        return journeyList[index]
    }
    
    func getList() {
        var list = [Journey]()
        isLoading = true
        loadingStarted()
        let endPoint = APIEndpoint.journeyList(userKey: UserData.shared.userKey)
        api.requestData(endPoint: endPoint, dataType: [Journey].self) { result in
            switch result {
            case .success(let journey):
                journey.forEach {
                    if Int($0.eDate)! >= Int(self.currentDate)! {
                        list.append($0)
                    }
                }
                self.journeyList = list
                self.journeyListUpdated()
                self.loadingEnded()
                self.isLoading = false
            case .failure(let error):
                #if DEBUG
                print("getJourneyList error in \(error)")
                #endif
                self.loadingEnded()
                self.isLoading = false
                }
            }
    }
    
    // mypage의 지난 여행 불러오기
    
    func getPreviousList() {
        var list = [Journey]()
        isLoading = true
        loadingStarted()
        self.journeyListUpdated()
        self.loadingEnded()
        let endPoint = APIEndpoint.journeyList(userKey: UserData.shared.userKey)
        api.requestData(endPoint: endPoint, dataType: [Journey].self) { result in
            switch result {
            case .success(let journey):
                journey.forEach {
                    if Int($0.eDate)! < Int(self.currentDate)! {
                        list.append($0)
                    }
                }
                self.journeyList = list
                self.journeyListUpdated()
                self.loadingEnded()
                self.isLoading = false
            case .failure(let error):
                #if DEBUG
                print("getJourneyList error in \(error)")
                #endif
                self.loadingEnded()
                self.isLoading = false
                }
            }
    }
}

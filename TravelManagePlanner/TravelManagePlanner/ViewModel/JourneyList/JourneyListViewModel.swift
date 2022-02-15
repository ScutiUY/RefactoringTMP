//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var repo = JourneyListRepository()
    
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
        repo.getJourneyList(completed: { result in
            result.forEach {
                if Int($0.eDate)! >= Int(self.currentDate)! {
                    list.append($0)
                }
            }
            self.journeyList = list
            print(#function, self.journeyList.count)
            self.journeyListUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
    
    // mypage의 지난 여행 불러오기
    
    func getPreviousList() {
        var list = [Journey]()
        isLoading = true
        loadingStarted()
        repo.getJourneyList(completed: { result in
            result.forEach {
                if Int($0.eDate)! < Int(self.currentDate)! {
                    list.append($0)
                }
            }
            self.journeyList = list
            self.journeyListUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
}

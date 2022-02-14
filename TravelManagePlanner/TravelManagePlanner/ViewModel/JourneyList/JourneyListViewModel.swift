//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var repo = JourneyListRepository()
    
    private var journeyList = JourneyList.shared.data
    private var isLoading = false
    
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
        isLoading = true
        loadingStarted()
        repo.getJourneyList(completed: { result in
            self.journeyList = result
            self.journeyListUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
}

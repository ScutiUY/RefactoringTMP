//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var repo = JourneyListRepository()
    
    private var journeyList: JourneyList = JourneyList.shared
    private var isLoading = false
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var journeyListUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func journeyListCount() -> Int {
        return journeyList.journeys.count
    }
    func journey(index: Int) -> Journey {
        return journeyList.journeys[index]
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

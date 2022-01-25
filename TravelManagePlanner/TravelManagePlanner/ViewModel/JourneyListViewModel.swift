//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var api = APIRequest()
    
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
        api.getJourneyList(completed: { result in
            switch result {
            case .success(let str):
                //self.journeyList = str
                self.journeyListUpdated()
                self.loadingEnded()
                self.isLoading = false
            case .failure(let error):
                self.failedJourneyListUpdate()
                self.loadingEnded()
                self.isLoading = false
            }
        })
    }
    func count() -> Int {
        return journeyList.journeys.count
    }
    
}

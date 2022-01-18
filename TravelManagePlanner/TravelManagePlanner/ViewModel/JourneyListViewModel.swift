//
//  JourneyListViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class JourneyListViewModel {
    
    private var api = APIRequest()
    
    var journeyList: JourneyList = JourneyList.shared {
        didSet {
            
        }
    }
    
    
    var loadingStarted: Observable = Observable("")
    var loadingEnded: Observable = Observable("")
    var journeyListUpdated: Observable = Observable("")
    
    func getPlanDataFromAPI() {
        api.getJourneyList { result in
            switch result {
            case .success(let str):
                self.journeyList
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    func count() -> Int {
        return journeyList.journeys.count
    }
    
}

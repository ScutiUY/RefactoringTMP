//
//  JourneyListDetailViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

class JourneyListDetailViewModel {
    
    private var repo = JourneyListRepository()
    private var detailList = Journey.shared
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func getData() {
     
    }
}

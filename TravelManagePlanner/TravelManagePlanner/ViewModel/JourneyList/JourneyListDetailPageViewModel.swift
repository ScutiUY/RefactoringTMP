//
//  JourneyListDetailPageViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/09.
//

import Foundation
import UIKit


class JourneyListDetailPageViewModel {
    
    private var journeyDetailList: [JourneyDetailData] = []
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func journey(idx: Int) -> JourneyDetailData {
        return journeyDetailList[idx]
    }
    
    func count() -> Int {
        return journeyDetailList.count
    }
    func getImage() -> UIImage {
        var img = UIImage(named: "Seoul1")!
        ImageLoader.loadImage(url: self.journeyDetailList[0].imgUrl) { image in
            if let image = image {
                img = image
            }
        }
        return img
    }
    func getData() {
    }
}


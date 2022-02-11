//
//  JourneyListDetailPageViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/09.
//

import Foundation
import UIKit


class JourneyListDetailPageViewModel {
    
    private var journeyDetailList = [JourneyDetailData]()
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    var dateDic = [String]()
    var dateIdx = 0
    
    func journey(idx: Int) -> JourneyDetailData {
        return journeyDetailList[idx]
    }
    
    func count() -> Int {
        var arr = [JourneyDetailData]()
        journeyDetailList.forEach{ arr.append($0) }
        return arr.filter{ $0.visitDate == dateDic[dateIdx]}.count
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
    
    func getList(journeyDetailDataFromPageCollectionView: [JourneyDetailData]) {
        self.journeyDetailList = journeyDetailDataFromPageCollectionView
        self.dataUpdated()
    }
}


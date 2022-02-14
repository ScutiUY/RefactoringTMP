//
//  JourneyListDetailPageViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/09.
//

import Foundation
import UIKit


class JourneyListDetailPageViewModel {
    
    private var journeyDetailList = [JourneyDetailData]() {
        didSet{
            journeyDetailList.forEach{
                if categoryDic[$0.category] == nil {
                    categoryDic[$0.category] = [$0]
                } else {
                    var journetList = categoryDic[$0.category]!
                    journetList.append($0)
                }
            }
        }
    }
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
   
    var categoryDic = [String: [JourneyDetailData]]()
    var categoryInOrder = ["1","2","3"] // category 바꿔야함 - 숙박, 여가, 음식점
    
    func journey(idx: Int) -> JourneyDetailData {
        return journeyDetailList[idx]
    }
                
    func destination(idx: Int) -> Int {
        return journeyDetailList[idx].idx
    }
    
    func categoriesCount() -> Int {
        return categoryDic.count
    }
    
    func countInSectionItems(idx: Int) -> Int {
        return categoryDic.filter{ $0.key == categoryInOrder[idx] }.count
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


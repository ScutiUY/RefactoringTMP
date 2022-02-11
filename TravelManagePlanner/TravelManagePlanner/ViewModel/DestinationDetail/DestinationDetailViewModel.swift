//
//  File.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit

class DestinationDetailViewModel {
    
    var repo = DestinationInfoRepositories()
    
    private var destinationInfo = DestinationData.shared
    
    var shopId = ""
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var dataUpdated: Observable = Observable(false)
    
    func getDestinationData() {
        repo.getDestinationDetailInfo(shopID: shopId) { data in
            self.destinationInfo = data
            self.dataUpdated.value = true
        }
    }
    var data: DestinationData {
        return destinationInfo
    }
    func imagesCount() -> Int {
        return destinationInfo.imgUrl.count
    }
    func getImage(index: Int) -> String {
        return destinationInfo.images[index]
    }
}

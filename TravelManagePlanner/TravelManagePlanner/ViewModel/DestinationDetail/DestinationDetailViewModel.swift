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
    
    private var destinationInfo: DestinationDetailData.DestinationData = DestinationDetailData.shared.data {
        didSet {
            //self.updated()
        }
    }
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var dataUpdated: Observable = Observable(false)
    
    func getDestinationData() {
        repo.getDestinationDetailInfo { data in
            self.destinationInfo = data.data
            self.dataUpdated.value = true
            self.getImage()
        }
    }
    var data: DestinationDetailData.DestinationData {
        return destinationInfo
    }
    func imagesCount() -> Int {
        return destinationInfo.imgUrl.count
    }
    func getImage(index: Int) -> String {
        return destinationInfo.imgUrl[index]
    }
    func getImage(){
        
        for imageUrl in destinationInfo.imgUrl {
            ImageLoader.loadImage(url: imageUrl) { _ in }
        }
    }
}

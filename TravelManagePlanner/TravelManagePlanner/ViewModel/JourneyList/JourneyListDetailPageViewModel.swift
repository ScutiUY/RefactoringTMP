//
//  JourneyListDetailPageViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/09.
//

import Foundation
import UIKit


class JourneyListDetailPageViewModel {
    
    var title = ""
    var imgUrl = ""
    var desc = ""
    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    func count() -> Int {
        return 0
    }
    func getImage() -> UIImage {
        var img = UIImage(named: "Seoul1")!
        ImageLoader.loadImage(url: self.imgUrl) { image in
            if let image = image {
                img = image
            }
        }
        return img
    }
    func getData() {
    }
}


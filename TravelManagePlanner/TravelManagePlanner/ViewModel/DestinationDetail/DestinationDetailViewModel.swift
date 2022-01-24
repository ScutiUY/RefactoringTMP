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
    
    var destTitle = ""
    var destDesc = ""
    var destImages = [String]()
    
    func getDestinationData() {
        repo.getDestinationDetail { data in
            print(data)
        }
    }
    func data() {
        
    }
    
}

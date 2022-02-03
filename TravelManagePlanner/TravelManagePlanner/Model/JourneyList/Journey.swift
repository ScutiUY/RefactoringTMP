//
//  Travel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation
import UIKit

struct Journey: Codable {

    static var shared = Journey(name: "", desc: "", date: "", journeyDetail: [])
    
    //let type: ContentType
    let name: String
    let desc: String
    let date: String
    let journeyDetail: [JourneyDetail]

    init(name: String, desc: String, date: String, journeyDetail: [JourneyDetail]) {
      
        self.name = name
        self.desc = desc
        self.date = date
        self.journeyDetail = journeyDetail
    }
    
    
}

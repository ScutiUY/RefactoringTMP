//
//  Travel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation
import UIKit

struct Journey: Codable {

    static var shared = Journey(name: "", desc: "", date: "", image: "")
    
    //let type: ContentType
    let name: String
    let desc: String
    let date: String
    let image: String

    init(name: String, desc: String, date: String, image: String) {
      //  self.type = type
        self.name = name
        self.desc = desc
        self.date = date
        self.image = image
    }
    
    enum ContentType {
        case accommodation
        case restaurant
        case attraction
    }
}

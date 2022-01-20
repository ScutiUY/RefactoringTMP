//
//  JourneyDetailData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/18.
//

import Foundation

struct ContentDetailData: Codable {
    
    static var shared = ContentDetailData(title: "", desc: "", images: [])
    
    var title: String
    var desc: String
    var images: [String]
    
    init(title: String, desc: String, images: [String]) {
        self.title = title
        self.desc = desc
        self.images = images
    }
}

struct ContentDetailImage: Codable {
    static var shared = ContentDetailImage(title: "", link: "")
    let title: String
    let link: String
}

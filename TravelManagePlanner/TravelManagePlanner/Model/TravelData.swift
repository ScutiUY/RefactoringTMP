//
//  TravelData.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit

struct JourneyData: Codable {
    static let shared = JourneyData(title: "", desc: "", images: [])
    let title: String
    let desc: String
    var images = [JourneyImage]()
    
    init(title: String, desc: String, images: [JourneyImage]) {
        self.title = title
        self.desc = desc
        self.images = images
    }
}

struct JourneyImage: Codable {
    static var empty = JourneyImage(title: "", link: "", height: "", width: "")
    let title: String
    let link: String
    let height: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case height = "sizeheight"
        case width = "sizewidth"
    }
}

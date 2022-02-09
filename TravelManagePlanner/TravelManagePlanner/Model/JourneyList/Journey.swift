//
//  Travel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation
import UIKit

struct Journey: Codable {
    
    static var shared = Journey(idx: 0, title: "", imgUrl: "", sDate: "", eDate: "", theme: "")
    
    let imgUrl: String
    let theme: String
    let sDate: String
    let idx: Int
    let title: String
    let eDate: String
    
    init(idx: Int, title: String, imgUrl: String, sDate: String, eDate: String, theme: String) {
        self.idx = idx
        self.title = title
        self.imgUrl = imgUrl
        self.sDate = sDate
        self.eDate = eDate
        self.theme = theme
    }
    
}

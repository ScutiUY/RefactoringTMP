//
//  GlobalConstants.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit

enum GlobalConstants {
    
    enum Font {
        enum Size {
            static var mainFontSize: CGFloat = 15
            static var descFontSize: CGFloat = 10
            static var journeyListTableViewCellTitleSize: CGFloat = 30
        }
    }
    
    enum Color {
        enum Text {
            static var buttonTextColor: UIColor = .white
            static var invalidateTextColor: UIColor = .red
        }
        enum Background {
            static var themeColor: UIColor = UIColor(red: 131/255, green: 247/255, blue: 178/255, alpha: 1)
            static var loginButtonbackgroundColor: UIColor = .blue
        }
        
    }
    
}

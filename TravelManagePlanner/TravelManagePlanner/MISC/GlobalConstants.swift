//
//  GlobalConstrants.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import Foundation
import UIKit

enum GlobalConstants {
    
    enum Font {
        enum Size {
            static var mainFontSize: CGFloat = 15
            static var descFontSize: CGFloat = 10
            static var journeyListTableViewCellTitleSize: CGFloat = 30
            static var signUpLabelFontSize: CGFloat = 14
            
            static var versionCheckLabelSize: CGFloat = 15
        }
    }
    
    enum Color {
        enum Text {
            static var signInButtonTextColor: UIColor = .white
            static var signUpButtonTextColor: UIColor = .blue
            static var signUpLabelTextColor: UIColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
            static var findPasswordButtonTextColor: UIColor = .blue
            static var signUpResisterButtonTextColor: UIColor = .white
            static var invalidateTextColor: UIColor = .red
        }
        
        enum Background {
            static var themeColor: UIColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
            static var loginButtonbackgroundColor: UIColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        }
        
    }
    
}

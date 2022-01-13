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
            static var signUpLabelFontSize: CGFloat = 14
        }
    }
    
    enum Color {
        enum Text {
            static var SignInButtonTextColor: UIColor = .white
            static var SignUpButtonTextColor: UIColor = .blue
            static var SignUpLabelTextColor: UIColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
            static var FindPasswordButtonTextColor: UIColor = .blue
            static var SignUpResisterButtonTextColor: UIColor = .white
            static var invalidateTextColor: UIColor = .red
        }
        
        enum Background {
            static var themeColor: UIColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
            //UIColor(red: 131/255, green: 247/255, blue: 178/255, alpha: 1)
            static var loginButtonbackgroundColor: UIColor = UIColor(red: 85/255, green: 185/255, blue: 188/255, alpha: 1)
        }
        
    }
    
}

//
//  comminityFloatingButton.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/06.
//

import JJFloatingActionButton
import UIKit



// MARK: - JJFloatingButton
class communityFloatingButtonClass
{
    lazy var communityFloatingButton = JJFloatingActionButton().then {
        $0.buttonColor =  #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
        
        let firstButton = $0.addItem().then {
            $0.titleLabel.text = "리뷰 작성하기"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        }
        let secondButton = $0.addItem().then {
            $0.titleLabel.text = "내가 작성한 리뷰"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
            
        }
        let thirdButton = $0.addItem().then {
            $0.titleLabel.text = "북마크 리뷰"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
            
        }
    }
}


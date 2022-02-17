//
//  comminityFloatingButton.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/06.
//

import JJFloatingActionButton
import UIKit

// MARK: - JJFloatingButton
class CommunityFloatingButtonClass
{
    lazy var communityFloatingButton = JJFloatingActionButton().then {
        $0.buttonColor = GlobalConstants.Color.Background.communityButtonColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.2
        
        let firstButton = $0.addItem().then {
            $0.titleLabel.text = "리뷰 작성하기"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = GlobalConstants.Color.Background.communityButtonColor
        }
        let secondButton = $0.addItem().then {
            $0.titleLabel.text = "내가 작성한 리뷰"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = GlobalConstants.Color.Background.communityButtonColor
            
        }
        let thirdButton = $0.addItem().then {
            $0.titleLabel.text = "북마크 리뷰"
            $0.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            $0.buttonColor = GlobalConstants.Color.Background.communityButtonColor
            
        }
    }
}


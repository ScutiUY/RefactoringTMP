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
    lazy var communityFloatingButton : JJFloatingActionButton = {
        let actionButton = JJFloatingActionButton()
//        let alert = UIAlertController()
//        let defaultAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        
//        alert.title = "You Clicked!"
//        alert.addAction(defaultAction)
        
        actionButton.buttonColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        actionButton.addItem(title: "북마크 리뷰", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
//            alert.message = "\(item.titleLabel.text!)"
//            self.present(alert, animated: true)
        }

        actionButton.addItem(title: "내가 작성한 리뷰", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
//            alert.message = "\(item.titleLabel.text!)"
//            self.present(alert, animated: true, completion: nil)
        }

        actionButton.addItem(title: "리뷰 작성하기", image: nil) { item in
//            alert.message = "\(item.titleLabel.text!)"
//            self.present(alert, animated: true, completion: nil)
        }
        return actionButton
    }()
}

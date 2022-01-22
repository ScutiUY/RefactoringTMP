//
//  communitySearchBar.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/06.
//

import UIKit

// MARK: - UISearchBar (따로 분리 예정)

class CommunitySearchBarClass
{
    lazy var communitySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "여행지를 입력해주세요."
        searchBar.backgroundImage = UIImage() // searchBar 테두리 없애는 편법
        searchBar.setImage(UIImage(named: "icCaencel"), for: .clear, state: .normal)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.frame.size.height = 1
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 15.0
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.black
            
            if let rightView = textfield.rightView as? UIImageView {
                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트 정하기
                rightView.tintColor = UIColor.white
            }
        }
        return searchBar
    }()
}


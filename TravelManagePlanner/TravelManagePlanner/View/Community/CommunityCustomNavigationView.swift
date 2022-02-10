//
//  CommunityCustomNavigationView.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/10.
//

import UIKit
import Then
import SnapKit

class CommunityCustomNavigationView: UIView {

    // MARK: Properties
    lazy var NavTitle = UITextView().then {
        $0.text = "커뮤니티"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.backgroundColor = GlobalConstants.Color.Background.themeColor
    }
    lazy var NavSearchBar = UISearchBar().then {
        $0.placeholder = "여행지를 입력하세요."
        $0.searchTextField.backgroundColor = .white
        $0.searchTextField.layer.borderWidth = 0.2
        $0.searchTextField.layer.cornerRadius = 10
        $0.setImage(UIImage(named: "icCaencel"), for: .clear, state: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 85, height: 0)
        $0.backgroundImage = UIImage()
        $0.backgroundColor = GlobalConstants.Color.Background.themeColor
        $0.barTintColor = GlobalConstants.Color.Background.themeColor
    }

    lazy var NavTheme = UITextField().then {
        $0.text = "전체"
        $0.textColor = .lightGray
        $0.tintColor = .clear
        $0.font = .systemFont(ofSize: 17)
        $0.textAlignment = .center
        $0.frame = CGRect(x: 0, y: 0, width: 50, height: 0)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.2
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    private func setLayout() {
        self.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        self.addSubview(NavTitle)
        self.addSubview(NavSearchBar)
        self.addSubview(NavTheme)
        
        NavTitle.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(39)
            $0.width.equalTo(self.snp.width).multipliedBy(0.5)
            $0.height.equalTo(self.snp.height).multipliedBy(0.32)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        NavSearchBar.snp.makeConstraints {
            $0.top.equalTo(NavTitle.snp.bottom).offset(-5)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.width.equalTo(self.snp.width).multipliedBy(0.6)
            $0.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        
        NavTheme.snp.makeConstraints {
            $0.centerY.equalTo(self.NavSearchBar.searchTextField.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing).offset(-20)
            $0.width.equalTo(self.snp.width).multipliedBy(0.3)
            $0.height.equalTo(self.snp.height).multipliedBy(0.27)
        }
    }

}

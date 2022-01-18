//
//  JourneyDetailDateCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListDetailDateCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.text = "Test - test"
        return label
    }()
    
    func setLayout() {
        self.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

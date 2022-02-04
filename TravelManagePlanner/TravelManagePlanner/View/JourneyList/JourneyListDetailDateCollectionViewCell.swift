//
//  JourneyDetailDateCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListDetailDateCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        willSet {
            self.setSelected(newValue)
        }
    }
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
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
    func setLabelName(name: String) {
        dateLabel.text = name
    }
    private func setSelected(_ selected: Bool) {
            if selected {
                self.backgroundColor = .red
            } else {
                self.backgroundColor = .clear
            }
        }
    
}

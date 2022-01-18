//
//  JourneyDetailDateCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class JourneyListDetailDateCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .red : .clear
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
    func selected() {
        dateLabel.backgroundColor = .red
    }
    func deseleted() {
        dateLabel.backgroundColor = .clear
    }
    
}

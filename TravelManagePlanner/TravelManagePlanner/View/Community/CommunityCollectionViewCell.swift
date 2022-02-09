//
//  CommunityCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import UIKit
import SnapKit

class CommunityCollectionViewCell: UICollectionViewCell {
    
    lazy var anchorStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var thumNailImage: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Title"
        return label
    }()
    
    lazy var hashtagLabel: UILabel = {
        var label = UILabel()
        label.text = "hashTags"
        return label
    }()
    
    func setLayout() {
        
        self.addSubview(anchorStackView)
        anchorStackView.addArrangedSubview(thumNailImage)
        anchorStackView.addArrangedSubview(titleLabel)
        anchorStackView.addArrangedSubview(hashtagLabel)
        
        anchorStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        thumNailImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        hashtagLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
}

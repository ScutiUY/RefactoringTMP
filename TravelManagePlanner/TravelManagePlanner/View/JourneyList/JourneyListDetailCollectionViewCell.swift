//
//  JorneyListDetailCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/13.
//

import UIKit
import SnapKit

class JourneyListDetailCollectionViewCell: UICollectionViewCell {
    
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
    
    lazy var descLabel: UILabel = {
        var label = UILabel()
        label.text = "description"
        return label
    }()
    
    func setLayout() {
        
        self.addSubview(anchorStackView)
        anchorStackView.addArrangedSubview(thumNailImage)
        anchorStackView.addArrangedSubview(titleLabel)
        anchorStackView.addArrangedSubview(descLabel)
        
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
        descLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    func fetchData(idx: Int) {
        self.titleLabel.text = JourneyDetail.shared.data[idx].name
        self.descLabel.text = JourneyDetail.shared.data[idx].address
         ImageLoader.loadImage(url: JourneyDetail.shared.data[idx].imgUrl, completed: { image in
             self.thumNailImage.image = image
        })
    }
}

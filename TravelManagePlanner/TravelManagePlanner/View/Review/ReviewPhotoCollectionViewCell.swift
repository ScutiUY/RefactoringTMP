//
//  reviewPhotoCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/20.
//

import UIKit

class ReviewPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCell"
    
    lazy var imageSelectedView = UIImageView().then {
        $0.backgroundColor = GlobalConstants.Color.Background.themeColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    lazy var imageShadowView = UIView().then {
        $0.layer.shadowOffset = CGSize(width: 5, height: 5)
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowRadius = 5
        $0.layer.shadowColor = UIColor.gray.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        CellSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func CellSetup()
    {
        addSubview(imageShadowView)
        imageShadowView.addSubview(imageSelectedView)
        
        imageSelectedView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
        
        imageShadowView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(0.9)
        }
    }
}

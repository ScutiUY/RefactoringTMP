//
//  reviewPhotoCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/20.
//

import UIKit

class ReviewPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CellSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageSelectedView = UIImageView()
    
    func CellSetup()
    {
        imageSelectedView.backgroundColor = GlobalConstants.Color.Background.themeColor
        
        addSubview(imageSelectedView)
        
        imageSelectedView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(0.9)
        }
    }
}

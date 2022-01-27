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
        imageSelectedView.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 251/255, alpha: 1)
        
        addSubview(imageSelectedView)
        
        imageSelectedView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

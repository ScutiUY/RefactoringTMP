//
//  reviewPhotoCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/01/20.
//

import UIKit

class reviewPhotoCollectionViewCell: UICollectionViewCell {
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
        imageSelectedView.backgroundColor = .blue
        
        addSubview(imageSelectedView)
        
        imageSelectedView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(20)
        }
    }
}

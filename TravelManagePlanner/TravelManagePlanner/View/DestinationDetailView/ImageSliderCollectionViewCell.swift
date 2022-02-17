//
//  ImageSliderCollectionViewCell.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import UIKit
import SnapKit

class ImageSliderCollectionViewCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setLayout() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func setCollectionViewIngredient(imageUrl: String) {
        ImageLoader.loadImage(url: imageUrl) { image in
            self.imageView.image = image
        }
    }
    func setImage(image: UIImage?) {
        self.imageView.image = image
    }
}

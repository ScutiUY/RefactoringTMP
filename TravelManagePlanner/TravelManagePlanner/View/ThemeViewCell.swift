//
//  ThemeViewCell.swift
//  TravelManagerPlanner
//
//  Created by YoonDaeSung on 2022/01/02.
//

import UIKit

class ThemeViewCell: UICollectionViewCell {
    
    lazy var imgButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
//    let imageView: UIImageView = {
//           let iv = UIImageView()
//           iv.contentMode = .scaleAspectFit
//           return iv
//    }()
    
    // 함수생성후 뷰컨에서 호출 이미지를 뷰컨에서 넘겨줌
    func cellLoadImage(_ imgData: String) {
        
        imgButton.setImage(UIImage(named: imgData), for: .normal)
        imgButton.imageView?.layer.cornerRadius = 10
        imgButton.layer.shadowColor = UIColor.black.cgColor
        imgButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        imgButton.layer.shadowRadius = 5
        imgButton.layer.shadowOpacity = 0.3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        
        addSubview(imgButton)
        
        imgButton.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
            
        }
     
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}

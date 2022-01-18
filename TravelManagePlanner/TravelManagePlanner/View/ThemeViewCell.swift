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
//        button.setImage(UIImage(named: "가족"), for: .normal)
        
        return button
    }()
    
    let imageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFit
           return iv
    }()
    
    // 함수생성후 뷰컨에서 호출 이미지를 뷰컨에서 넘겨줌
    func cellLoadImage(_ imgData: String) {
        
        imgButton.setImage(UIImage(named: imgData), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        
        self.backgroundColor = .red
        
        addSubview(imgButton)
        imgButton.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
            
        }
     
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}

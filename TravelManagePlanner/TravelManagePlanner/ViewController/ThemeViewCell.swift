//
//  ThemeViewCell.swift
//  TravelManagerPlanner
//
//  Created by YoonDaeSung on 2022/01/02.
//

import UIKit
import SnapKit

class ThemeViewCell: UICollectionViewCell {
    
    lazy var imgButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "가족"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        
        self.backgroundColor = .red
        
        addSubview(imageView)
            imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
            
        }
     
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            return iv
        }()
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}

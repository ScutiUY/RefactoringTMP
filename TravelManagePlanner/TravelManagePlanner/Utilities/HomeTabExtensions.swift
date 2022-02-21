//
//  HomeTabExtensions.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/22.
//

import Foundation
import UIKit

// 버튼icon 색상 입히기
extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}

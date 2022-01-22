//
//  UIImage+extension.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/02.
//

import Foundation
import UIKit

extension UIImage {

    func resizedImage(targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

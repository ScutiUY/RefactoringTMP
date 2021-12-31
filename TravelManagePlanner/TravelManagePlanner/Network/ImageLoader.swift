//
//  ImageLoader.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/31.
//

import Foundation
import UIKit

class ImageLoader {
    private static var imageCache = [String: UIImage]()

    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            completed(nil)
            return
        }

        if let image = imageCache[url] {
            DispatchQueue.main.async {
                completed(image)
            }
            return
        }

        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completed(image)
                }
            } else {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }
}

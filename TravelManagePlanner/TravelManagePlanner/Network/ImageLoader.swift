//
//  ImageLoader.swift
//  TravelManagePlanner
//
//  Created by UY on 2021/12/31.
//

import UIKit

private enum ImageLoaderError: Error {
    case noImage
    case invalidImageURL
}

final class ImageLoader {
    
    static let shard = ImageLoader()
    static let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if url.isEmpty {
            completion(.failure(ImageLoaderError.invalidImageURL))
        }
        if let image = ImageLoader.imageCache.object(forKey: url as NSString) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: url) else { return }
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: imageUrl) { data, response, error in
                if error == nil {
                    completion(.failure(ImageLoaderError.invalidImageURL))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    return
                }
                
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    ImageLoader.imageCache.setObject(image, forKey: url as NSString)
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(ImageLoaderError.noImage))
                    }
                }
            }
            task.resume()
        }
    }
}

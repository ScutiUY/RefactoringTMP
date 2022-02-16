//
//  ReviewViewModel.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import Foundation
import UIKit

class ReviewViewModel {
    
    private var repo = ReviewDataRepository()
    private var makeItJSON : Dictionary<String, String> = [:]
    
    var isLoading = false
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }

    func setReviewData() {
        isLoading = true
        loadingStarted()
        repo.setReviewData(completed: {
            result in
            self.loadingEnded()
            self.isLoading = false
        })
    }

    func setReviewParams(reviewData: ReviewData, idx : Int) {
        repo.setReviewParams(reviewData: reviewData, idx: idx)
    }
    
    func setReviewDataWithImage(reviewData: ReviewData, idx: Int, previousImages: [UIImage]) {
        
        var resizedImages : [UIImage] = []
        
        for i in 0..<previousImages.count {
            resizedImages.append(resizeImage(image: previousImages[i], targetSize: CGSize(width: 100, height: 200)))
        }
        
        repo.imgUpload(imageData: resizedImages)
        
    }

    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


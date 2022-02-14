//
//  ReviewViewModel.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import Foundation

class ReviewViewModel {
    
    private var repo = ReviewDataRepository()
    
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

    func setReviewParams(reviewData: ReviewData) {
        repo.setReviewParams(reviewData: reviewData)
    }
    
    
    
    
    
    
    
    
}

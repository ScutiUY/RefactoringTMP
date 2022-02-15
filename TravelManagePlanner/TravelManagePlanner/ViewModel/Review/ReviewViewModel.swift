//
//  ReviewViewModel.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import Foundation

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
    
    
    
    
    
    
    
    
}

//
//  ReviewDataRepository.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/13.
//

import Foundation
import Alamofire

class ReviewDataRepository {
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    private var params: [String : Any] = [
        "title" : "",
        "startDate" : "",
        "endDate" : "",
        "content" : "",
        "tags" : "",
        "theme" : "",
        "shopList" : []]
    
    func setReviewData(completed: @escaping(ReviewResponseData) -> Void) {
        httpClient.getJsonData(path: "/rvw/inputReviewInfo.tpi", params: params) { result in

            let data = try! result.get()
            let decodedData = try? JSONDecoder().decode(ReviewResponseData.self, from: data)
            if let reviewResponseData = decodedData {
                print(reviewResponseData)
                completed(reviewResponseData)
            }
            else {
                print("setReviewData error in ReviewDataRepository")
                }
            }
    }

    func setReviewParams(reviewData: ReviewData) {
        self.params["title"] = reviewData.title
        self.params["startDate"] = reviewData.startDate
        self.params["endDate"] = reviewData.endDate
        self.params["content"] = reviewData.content
        self.params["tags"] = reviewData.tags
        self.params["theme"] = reviewData.theme
        self.params["shopList"] = reviewData.shopList
        print(params)
    }
    
}

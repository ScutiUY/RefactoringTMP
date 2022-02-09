//
//  CommunityDataRepository.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import Foundation
import Alamofire

class CommunityDataRepository {

    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    private var params = ""
    
    func getCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi") { result in
        let data = try! result.get()
        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
        if let communityList = decodedData {
            print(communityList)
            completed(communityList)
        } else {
            print("getCommunity error in CommunityDataRepository")
            }
        }
    }
}

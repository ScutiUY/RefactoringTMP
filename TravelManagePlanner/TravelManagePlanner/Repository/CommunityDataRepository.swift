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
    private var params = ["uKey": "10000001"]
    
    // do - catch로 수정 예정
    // 전체 커뮤니티 데이터 불러오기
    // 지금은 params을 넣어야 되는 것으로 서버가 되어있어서 params을 넣었지만 빼야함
    func getCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi") { result in
        print("\(result) <- 1. API 잘 들어오는 지 확인")
        let data = try! result.get()
        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
        if let communityList = decodedData {
            print(communityList)
            completed(communityList)
        }
        else {
            print("getCommunity error in CommunityDataRepository")
            }
        }
    }

    // 내가 작성한 글만 볼 수 있게
    func getPersonalCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: params) { result in
        print("\(result) <- 2. API 잘 들어오는 지 확인")
        let data = try! result.get()
        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
        if let communityList = decodedData {
            print(communityList)
            completed(communityList)
        }
        else {
            print("getPersonalCommunityData error in CommunityDataRepository")
            }
        }
    }
}


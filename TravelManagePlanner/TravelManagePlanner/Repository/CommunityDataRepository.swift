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
    
    
    // 여기에는 param이 들어갔고, 커뮤니티는 전체보기가 있어야하니까 params를 없애야한다.
    // 내 글 보기를 하면 params를 넣어야한다.
    // do - catch로 수정 예정
    func getCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: params) { result in
        print("\(result) <- API 잘 들어오는 지 확인")
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
}


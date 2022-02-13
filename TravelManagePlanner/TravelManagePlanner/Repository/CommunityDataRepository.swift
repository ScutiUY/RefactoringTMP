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
    private var params = ["searchType": "A"]
    private var personalParams = ["uKey": "10000001", "searchType" : "S"]
    private var searchParams : [String : String] = ["searchWord": ""]
    var searchWord : String = ""
    
    // do - catch로 수정 예정
    // 전체 커뮤니티 데이터 불러오기
    func getCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: params) { result in
        let data = try! result.get()
        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
        if let communityList = decodedData {
            completed(communityList)
        }
        else {
            print("getCommunity error in CommunityDataRepository")
            }
        }
    }

    // 내가 작성한 글만 볼 수 있게
    func getPersonalCommunityData(completed: @escaping (CommunityData) -> Void) { httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: personalParams) { result in
        let data = try! result.get()
        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
        if let communityList = decodedData {
            completed(communityList)
        }
        else {
            print("getPersonalCommunityData error in CommunityDataRepository")
            }
        }
    }
    
    // 커뮤니티 검색하기
    func getSearchCommunityData(completed: @escaping (CommunityData) -> Void) {
        httpClient.getJsonData(path: "/rvw/getReviewSearchList.tpi", params: searchParams) { result in
            let data = try! result.get()
            let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
            if let communityList = decodedData {
                completed(communityList)
            }
            else {
                print("getPersonalCommunityData error in CommunityDataRepository")
                }
            }
    }
    
    // 검색어 param 넣어주기 
    func putSearchWord(word: String)
    {
        self.searchWord = word
        self.searchParams["searchWord"] = self.searchWord
    }
}


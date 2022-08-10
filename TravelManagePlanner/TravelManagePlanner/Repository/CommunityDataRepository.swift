//
//  CommunityDataRepository.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import Foundation
import Alamofire

class CommunityDataRepository {

    private let httpClient = HttpClient()
    private var params = ["searchType": "A"]
    private var personalParams = ["uKey": "10000001", "searchType" : "S"]
    private var searchParams : [String : String] = ["searchWord": ""]
    var searchWord : String = ""
    
    // do - catch로 수정 예정
    // 전체 커뮤니티 데이터 불러오기
    func getCommunityData(completed: @escaping (CommunityData) -> Void) {
//        httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: params) { result in
//        let data = try! result.get()
//        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
//        if let communityList = decodedData {
//            completed(communityList)
//        }
//        else {
//            print("getCommunity error in CommunityDataRepository")
//            }
//        }
    }

    // 내가 작성한 글만 볼 수 있게
    func getPersonalCommunityData(completed: @escaping (CommunityData) -> Void) {
//        httpClient.getJsonData(path: "/rvw/getReviewList.tpi", params: personalParams) { result in
//        let data = try! result.get()
//        let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
//        if let communityList = decodedData {
//            completed(communityList)
//        }
//        else {
//            print("getPersonalCommunityData error in CommunityDataRepository")
//            }
//        }
    }
    
    // 커뮤니티 검색하기
    func getSearchCommunityData(completed: @escaping (CommunityData) -> Void) {
        
//        httpClient.getJsonData(path: "/rvw/getReviewSearchList.tpi", params: searchParams) { result in
//            let data = try! result.get()
//            let decodedData = try? JSONDecoder().decode(CommunityData.self, from: data)
//            if let communityList = decodedData {
//                completed(communityList)
//            }
//            else {
//                print("getPersonalCommunityData error in CommunityDataRepository")
//                }
//            }
    }
    
    // 검색어 param 넣어주기 
    func putSearchWord(word: String)
    {
        self.searchWord = word
        self.searchParams["searchWord"] = self.searchWord
    }
    
    
    
    // image upload Test
        func imgUpload(imageData: [UIImage]) {
            // 파라미터도 추가가능
            let URL = URL(string: "https://eunryuplaners.com:19624/rvw/inputReviewInfoWithImage.tpi")!
            let header : HTTPHeaders = ["Content-Type" : "multipart/form-data", "appCode": "TMP_iOS"]
            let parameters: Dictionary<String, Any> = ["jsonString": "{\"uKey\": \"10000001\",\"title\": \"test\",\"startDate\": \"20220201\",\"endDate\": \"20220205\",\"content\": \"테스트 데이터 입니다.\", \"tags\": \"#태그 #태그2 #태그3\", \"theme\":\"test\", \"imgUrl\": \"test\", \"shopList\": [{\"sIdx\": \"1\",\"vDate\": \"20220201\"}, {\"sIdx\": \"2\",\"vDate\": \"20220202\"}, {\"sIdx\": \"2\",\"vDate\": \"20220203\"}]}"]
            
            AF.upload(multipartFormData: { multipartFormData in
                // 멀티파트 String 데이터 입력
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                
                // 멀티파트 이미지 입력
                var cnt = 0
                for img in imageData {
                    if let image = img.jpegData(compressionQuality: 1) {
                        let fileName = "\(cnt)_test.jpg"
                        multipartFormData.append(image, withName: "uploadfile", fileName: fileName, mimeType: "image/jpeg")
                        cnt = cnt + 1
                    }
                }
            }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).responseString { response in
                if response.value != nil {
                    print("uploadResult :: \(response.value)")
                }
            }
        }
    
    
    
    
    
    
    
    
    
}


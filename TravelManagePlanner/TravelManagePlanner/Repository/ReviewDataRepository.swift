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
        "uKey" : "10000001",
        "title" : "",
        "startDate" : "",
        "endDate" : "",
        "content" : "",
        "tags" : "",
        "theme" : "",
        "shopList" : ["":""]]
    private var finalparam : [String : Any] = ["jsonString" : ""]

    func setReviewData(completed: @escaping(ReviewResponseData) -> Void) {
        httpClient.getJsonData(path: "/rvw/inputReviewInfo.tpi", params: finalparam) { result in

            let data = try! result.get()
            let decodedData = try? JSONDecoder().decode(ReviewResponseData.self, from: data)
            if let reviewResponseData = decodedData {
                completed(reviewResponseData)
            }
            else {
                print("setReviewData error in ReviewDataRepository")
                }
            }
    }

    func setReviewParams(reviewData: ReviewData, idx: Int) {
        var jsonObj: String = ""
        var willPutInParams = [Dictionary<String, String>]()
        
        self.params["shopList"] = nil
        self.params["title"] = reviewData.title
        self.params["startDate"] = reviewData.startDate
        self.params["endDate"] = reviewData.endDate
        self.params["content"] = reviewData.content
        self.params["tags"] = reviewData.tags
        self.params["theme"] = reviewData.theme
        self.params["shopList"] = [Dictionary<String, String>]()

        for i in 0..<reviewData.shopList.count {
            let tmp = ["sIdx": String(reviewData.shopList[i].sIdx), "vDate" : String(reviewData.shopList[i].vDate)]
            willPutInParams.append(tmp)
        }
        self.params["shopList"]! = willPutInParams


        if JSONSerialization.isValidJSONObject(params)
        {
            do {
                let JsonData = try JSONSerialization.data(withJSONObject: self.params, options: .prettyPrinted)
                jsonObj = String(data: JsonData, encoding: .utf8) ?? ""
            } catch {
                print(error.localizedDescription)
            }
        }
        finalparam["jsonString"] = jsonObj
    }
}



//
//// image upload Test
//    func imgUpload(imageData: [UIImage]) {
//        // 파라미터도 추가가능
//        let URL = URL(string: "https://eunryuplaners.com:19624/rvw/inputReviewInfoWithImage.tpi")!
//        let header : HTTPHeaders = ["Content-Type" : "multipart/form-data", "appCode": "TMP_iOS"]
//        let parameters: Dictionary<String, Any> = ["jsonString": "{\"uKey\": \"10000001\",\"title\": \"test\",\"startDate\": \"20220201\",\"endDate\": \"20220205\",\"content\": \"테스트 데이터 입니다.\", \"tags\": \"#태그 #태그2 #태그3\", \"theme\":\"test\", \"imgUrl\": \"test\", \"shopList\": [{\"sIdx\": \"1\",\"vDate\": \"20220201\"}, {\"sIdx\": \"2\",\"vDate\": \"20220202\"}, {\"sIdx\": \"2\",\"vDate\": \"20220203\"}]}"]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            // 멀티파트 String 데이터 입력
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//            }
//
//            // 멀티파트 이미지 입력
//            var cnt = 0
//            for img in imageData {
//                if let image = img.jpegData(compressionQuality: 1) {
////                    let dateFormatter = DateFormatter()
////                    dateFormatter.dateFormat = "yyyyMMddHHmmss"
//                    //dateFormatter.string(from: Date()) +
//                    let fileName = "\(cnt)_test.jpg"
//                    multipartFormData.append(image, withName: "uploadfile", fileName: fileName, mimeType: "image/jpeg")
//
//                    cnt = cnt + 1
//                }
//            }
//        }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).responseString { response in
//            if response.value != nil {
//                print("uploadResult :: \(response.value)")
//            }
//        }
//    }
//
//}

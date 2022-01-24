//
//  Repositories.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/20.
//

import Foundation
import Alamofire

class DestinationInfoRepositories: NSObject {

    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    private var params = ""
    
    func getDestinationDetail(completed: @escaping (DestinationDetailData) -> Void) {
        httpClient.getJson(path: "/plan/getAllShopList.tpi") { [self] result in
            
            if let json = try? result.get() {
                print(String(data: json, encoding: .utf8))
                //completed(parseDestinationData(jsonObject: self.JSONObject(json)))
                let d = try! JSONDecoder().decode(DestinationDetailData.self, from: json)
                print(d)
            }
        }
    }

    private func JSONObject(_ json: String) -> [String: Any] {
        let data = json.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        return jsonObject
    }
    
//    private func parseDestinationData(jsonObject: [String: Any]) -> DestinationDetailData {
//        print("jsonObject",jsonObject)
//
//        let destData = JSONObject(jsonObject["data"] as! String)
//
//
//        return DestinationDetailData(resCode: "", resMsg: "", data: [DestinationDetailData.DestinationData(imgUrl: destData["imgUrl"] as! String, address: destData["address"] as! String, name: destData["name"] as! String, idx: destData["idx"] as! String, content: destData["content"] as! String)])
//        //[DestinationDetailData.DestinationData(imgUrl: destData["imgUrl"] as! String, address: destData["address"] as! String, name: destData["name"] as! String, idx: destData["idx"] as! String, content: destData["content"] as! String)]
//    }
}

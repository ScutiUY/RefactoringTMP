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
                //completed(parseDestinationData(jsonObjext: self.JSONObject(json)))
            }
            
            
//            if let json = try? result.get() {
//                completed(self.parseLecture(jsonObject: self.JSONObject(json)))
            }
        }

    private func JSONObject(_ json: String) -> [String: Any] {
        let data = json.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return jsonObject
    }
    
//    private func parseDestinationData(jsonObjext: [String: Any]) -> DestinationDetailData {
//        let destData = (jsonObjext["data"] as! String).data(using: .utf8)
//        let json = try String(contentsOf: destData, encoding: .utf8)
//
//        let destS = DestinationDetailData(idx: destData["idx"] as! String, name: destData["name"] as! String, address: destData["address"] as! String, imgUrl: [destData["imgUrl"] as! String], content: destData["content"] as! String)
//        return destS
//    }

//    private func parseLecture(jsonObject: [String: Any]) -> Lecture {
//        return Lecture(id: jsonObject["id"] as! String,
//                       number: jsonObject["number"] as! String,
//                       name: jsonObject["name"] as! String,
//                       classfyName: jsonObject["classfy_name"] as! String,
//                       middleClassfyName: jsonObject["middle_classfy"] as! String,
//                       courseImage: ((jsonObject["media"] as! [String: Any])["image"] as! [String: Any])["small"] as! String,
//                       courseImageLarge: ((jsonObject["media"] as! [String: Any])["image"] as! [String: Any])["large"] as! String,
//                       shortDescription: jsonObject["short_description"] as! String,
//                       orgName: jsonObject["org_name"] as! String,
//                       start: DateUtil.parseDate(jsonObject["start"] as! String),
//                       end: DateUtil.parseDate(jsonObject["end"] as! String),
//                       teachers: jsonObject["teachers"] as? String,
//                       overview: jsonObject["overview"] as? String)
//    }
}

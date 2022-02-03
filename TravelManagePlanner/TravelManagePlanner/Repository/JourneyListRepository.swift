//
//  JourneyListRepository.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/25.
//

import Foundation
import Alamofire

struct JourneyListRepository {
    
    private let httpClient = HttpClient(baseUrl: "https://scutiuy.github.io/testWebHosting/")
    
    func getJourneyList(completed: @escaping (JourneyList) -> Void) {
        httpClient.getJson { result in
            if let json = try? result.get() {
                let data = json.data(using: .utf8)
                let decodedData = try? JSONDecoder().decode(JourneyList.self, from: data!)
                if let journeyList = decodedData {
                    completed(journeyList)
                } else {
                    print("getJourneyList error in JourneyList repository")
                }
            }
            
        }
    }
//    func getJourneys(completed: @escaping (JourneyList) -> Void) {
//        httpClient.getJsonData(path: "") { result in
//            if let json = try? result.get() {
//                let decodedData = try? JSONDecoder().decode(Journey, from: json)
//            }
//        }
//    }
}



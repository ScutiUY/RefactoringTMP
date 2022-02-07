//
//  JourneyListRepository.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/25.
//

import Foundation

struct JourneyListRepository {
    
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
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
    
    func getJourneyDetialList(completed: @escaping (JourneyDetail) -> Void) {
        httpClient.getJsonData(path: "", params: [:]) { result in
            let data = try! result.get()
            let decodedData = try!  JSONDecoder().decode(JourneyDetail.self, from: data)
            completed(decodedData)
        }
    }
}



//
//  HomeTabData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

struct HomeTabData: Codable {
    
    // 싱글톤 사용 (let을 선언함으로써 인스턴스가 1회생성되는것에 대한 보장을함)
    static var shared = HomeTabData(themeData: "")
    var themeData: String
    
    // 인스턴스를 추가적으로 생성해주는것을 방지하기위해 private (ThreadSafe)
    private init(themeData: String) {
        self.themeData = themeData 
    }
}

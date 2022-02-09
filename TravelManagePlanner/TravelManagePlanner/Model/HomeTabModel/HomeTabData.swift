//
//  HomeTabData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

struct HomeTabData: Codable {
    
    // 싱글톤 사용 (let을 선언함으로써 인스턴스가 1회생성되는것에 대한 보장을함)
    static var shared = HomeTabData(themeData: "", dayToGocalendar: "", dayToComecalendar: "", numPeople:"", budgetAmount: "")
    
    // 테마설정
    var themeData: String
        
    // 세부설정
    var dayToGocalendar: String // 가는날
    var dayToComecalendar: String // 오는날
    var numPeople: String // 인원 수
    var budgetAmount: String // 예산
    
    
    // 인스턴스를 추가적으로 생성해주는것을 방지하기위해 private (ThreadSafe)
    init(themeData: String, dayToGocalendar: String, dayToComecalendar: String, numPeople: String, budgetAmount: String) {
        
        // 테마설정
        self.themeData = themeData
        
        // 세부설정
        self.dayToGocalendar = dayToGocalendar
        self.dayToComecalendar = dayToComecalendar
        self.numPeople = numPeople
        self.budgetAmount = budgetAmount
        
        
    }
}

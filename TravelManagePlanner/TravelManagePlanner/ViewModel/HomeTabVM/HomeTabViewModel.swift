//
//  ThemeViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

class HomeTabViewModel {
    
    // 모델 소유
    static var globalHomeTabData = HomeTabData(themeData: "", dayToGocalendar: "", dayToComecalendar: "", numPeople:"", budgetAmount: "")
    
    // repository 소유
    private var repo = HomeTabRepository()
    
    // 상태 정의
    private var isLoading: Bool = false
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    
////    테마 설정 데이터
//    private var userThemeData = "" // 테마 데이터

    
//    // 디테일 설정 데이터
//    private var journeyTextField = "" // 여행 제목
//    private var dayToGocalendar = "" // 가는날
//    private var dayToComecalendar = "" // 오는날
//    private var numPeople = "" // 인원 수
//    private var budgetAmount = "" // 예산
    
    func updateThemeData(userThemeData: String) {
        HomeTabViewModel.globalHomeTabData.themeData = userThemeData
    }
    
    func updateDetailSettingData(journeyTextField: String, dayToGocalendar: String, dayToComecalendar: String, numPeople: String, budgetAmount: String) {
        HomeTabViewModel.globalHomeTabData.themeData = journeyTextField
        HomeTabViewModel.globalHomeTabData.dayToGocalendar = dayToGocalendar
        HomeTabViewModel.globalHomeTabData.dayToComecalendar = dayToComecalendar
        HomeTabViewModel.globalHomeTabData.numPeople = numPeople
        HomeTabViewModel.globalHomeTabData.budgetAmount = budgetAmount
    }
    
    // VM에서 repository호출, repo에서 api통신 정의
    func register() {
        repo.setPlanRepository(homeTabData: HomeTabViewModel.globalHomeTabData) { result in
            
            self.isLoading = true
            
            print(result)
        }
        
        func getDestiPlace() {
            
        }
    }// class
}

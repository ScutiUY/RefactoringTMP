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
    // 목적지 모델 소유
    var destiSearchData = DestiSearchData(place: "")
    
    private var repo = HomeTabRepository()
    private var isLoading: Bool = false
    
//    테마 설정 데이터
    private var userThemeData = "" // 테마 데이터
    
    // 디테일 설정 데이터
    private var journeyTextField = "" // 여행 제목
    private var dayToGocalendar = "" // 가는날
    private var dayToComecalendar = "" // 오는날
    private var numPeople = "" // 인원 수
    private var budgetAmount = "" // 예산
    
    // 목적지
    private var userDestiData = ""
    
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
    
    func updateDestiSearchData(userDestiData: String) {
        destiSearchData.place = userDestiData
        print("장소 잘받아옴 : ", destiSearchData.place)
    }
    
    // 상태정의
    var loadingStarted: (() -> ()) = { }
    
    

    // VM에서 repository호출, repo에서 api통신 정의
    func register() {
        repo.setPlanRepository(homeTabData: HomeTabViewModel.globalHomeTabData) { result in
            
            self.isLoading = true
            
            print(result)
        }
        
        func getDestiPlace() {
            
        }
        
        //    func setThemeData() {
        //        // 테마 데이터 담을시에 로딩 활성화
        //        isLoading = true
        //        loadingStarted()
        //
        //        repo.setThemeData(completed: (homeTabData))
        //    }
    }// class
    
    // Date Picker 날짜 비교로직 이전날짜가 더 높으면 안됨
    
    // 인원수 제한 로직
    
    //
}

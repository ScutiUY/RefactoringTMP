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
    
    // 목적지 요청 모델 소유
    var destiSearchRequest = DestiSearchRequest(place: "")
    
    // 목적지 응답 모델 소유
    var destiSearchResponse = DestiSearchResponse.shared.data
    
    // repository 소유
    private var repo = HomeTabRepository()
    
    // 상태 정의
    private var isLoading: Bool = false
    var loadingStarted: (() -> ()) = {}
    var loadingEnded: (() -> ()) = { }
    
    
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
    
    // 목적지 기반 추천지 불러오기
    func updateDestiSearchData(userDestiData: String) {
        self.isLoading = true
        loadingStarted()
        
        destiSearchRequest.place = userDestiData
        repo.getPlaceRepository(placeData: destiSearchRequest, completed: { result in
            
            switch result {
            case .success(let responseData):
                print("responseData!", responseData)
                self.destiSearchResponse = responseData.data
            case .failure(let error):
                
                switch error {
                case .notFoundInDB:
                    self.destiSearchResponse = []
                case .unknown:
                    print("알수 없는 오류")
                case .jsonError:
                    print("Json 오류")
                case .invalidArgument:
                    print("매개변수 오류")
                case .badRequest:
                    print("400")
                case .notFound:
                    print("404")
                case .internalServerError:
                    print("repo error")
                case .omittedParams:
                    print("params error")
                case .ommittedHeader:
                    print("header error")
                case .invalidPw:
                    print("Pw error")
                }
            }
            
            self.isLoading = false
        })
    }
    
    func getDestiSearchCount() -> Int {
        print("이름가져오니", self.destiSearchResponse.description)
        print("모델",destiSearchResponse.count)
        return destiSearchResponse.count
    }
    
    func getName(idx: Int) -> String {
        
        return destiSearchResponse[idx].name
    }
    
    func getContent(idx: Int) -> String {
        
        return destiSearchResponse[idx].content
    }
    
    func getImg(idx: Int) -> String {
        return destiSearchResponse[idx].imgUrl
    }
    
    
    

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

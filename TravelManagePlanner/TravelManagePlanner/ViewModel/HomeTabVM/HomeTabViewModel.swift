//
//  ThemeViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

class HomeTabViewModel {
    
    // 모델 소유
    static var globalHomeTabData = HomeTabRequest(uKey: "", title: "", startDate: "", endDate: "", inviteNum:"", price: "", theme: "", shopList: [])
    
    // repository 소유
    private var repo = HomeTabRepository()
    
    // 상태 정의
    private var isLoading: Bool = false
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var dataUpdated: (() -> ()) = { }
    var failedJourneyListUpdate: (() -> ()) = { }
    
    // 테마 데이터 업데이트
    func updateThemeData(theme: String, uKey: String) {
        // 디비에 넣을 데이터로변경
        var changeTheme = theme
        switch theme {
        case "커플":
            changeTheme = "couple"
        case "가족":
            changeTheme = "family"
        case "우정":
            changeTheme = "friend"
        default:
            changeTheme = "etc"
        }
        
        HomeTabViewModel.globalHomeTabData.theme = changeTheme
        HomeTabViewModel.globalHomeTabData.uKey = uKey // 유저키 받는부분 추후 설정필요
    }
    
    // 디테일설정 데이터 업데이트
    func updateDetailSettingData(title: String, startDate: String, endDate: String, inviteNum: String, price: String) {
        
        if title == "" || title.count < 6 {
            //            print("제목을 6글자 이상 입력해주세요")
        }else {
            HomeTabViewModel.globalHomeTabData.title = title
        }
        
        HomeTabViewModel.globalHomeTabData.startDate = startDate
        HomeTabViewModel.globalHomeTabData.endDate = endDate
        HomeTabViewModel.globalHomeTabData.inviteNum = inviteNum
        HomeTabViewModel.globalHomeTabData.price = price
    }
    
    // 숙박, 맛집, 놀거리 설정 업데이트
    func updateRecommendData(shopList: [HomeTabRequestData]) {
        HomeTabViewModel.globalHomeTabData.shopList.append(contentsOf: shopList)
#if DEBUG
        print("accomoShopData", shopList)
        print("all Data: ", HomeTabViewModel.globalHomeTabData)
#endif
        
    }
    
}// class

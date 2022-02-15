//
//  HomeTabData.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

struct HomeTabRequest: Codable {
    
    // 여행 최종입력 데이터
    static var shared = HomeTabRequest(uKey: "", title: "", startDate: "", endDate: "", inviteNum:"", price: "", theme: "", shopList: [])
    
    var uKey: String // 유저키
    var title: String // 여행제목
    var startDate: String // 여행 가는날
    var endDate: String // 여행 돌아오는날
    var inviteNum: String // 인원 수
    var price: String // 예산
    var theme: String // 유저 선택 테마
    var shopList: [HomeTabRequestData] // 바구니에 담은 가게 리스트
    
    init(uKey: String, title: String, startDate: String, endDate: String, inviteNum: String, price: String, theme: String, shopList: [HomeTabRequestData] ) {
        
        self.uKey = uKey
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.inviteNum = inviteNum
        self.price = price
        self.theme = theme
        self.shopList = shopList
        
    }
}

// 가게리스트 정보 구조체(데이터)
struct HomeTabRequestData: Codable {
    
    static var shared = HomeTabRequestData(sIdx: "", vDate: "", leaveDate: "")
    
    var sIdx: String // 가게 인덱스
    var vDate: String // 가게 체크인 날짜 (방문일)
    var leaveDate: String // 가게 체크아웃 날짜, 식당과 놀거리는 방문일과 동일한 날짜 전달
    
    init(sIdx: String, vDate: String, leaveDate: String) {
        self.sIdx = sIdx
        self.vDate = vDate
        self.leaveDate = leaveDate
    }
}


// 여행계획 최종입력 응답
struct HomeTabResponse: Codable {
    
    static var shared = HomeTabResponse(resCode: "", resMsg: "", data: "")
    
    var resCode: String
    var resMsg: String
    var data: String?
    
    init(resCode: String, resMsg: String, data: String) {
        self.resCode = resCode
        self.resMsg = resMsg
        self.data = data
    }
}

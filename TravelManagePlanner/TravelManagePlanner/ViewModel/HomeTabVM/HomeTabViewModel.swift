//
//  ThemeViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

enum HomeTabValidationResult {
    case success
    case invalidThemeData
    case invalidDetailTitle // 제목 미입력
    // 가는날이 현재 날짜보다 더뒤에있음
    // 인원수가 너무 많음
    // 예산설정을 하지 않음
}


class HomeTabViewModel {
    //    1 버튼클릭시 해당데이터를 뷰모델에 전달
    //    2 뷰모델은 모델의 데이터를 소지 (Observer는 데이터를 가져오는것이 없기때문에 필요없음)
    //    3 model 에 데이터 최신화
    //    4 Repository내에 model데이터를 Encode하여 데이터 저장
    //    5 Encode된 데이터를 AF(Http Client)를 활용하여 서버에 전달
    
    private var api =  APIRequest()
    
    // 싱글톤 데이터 공유
    func updateThemeData(themeData: String) -> HomeTabValidationResult {
        if (themeData == nil) || (themeData == "") {
            // 알림창 띄우기
            return .invalidThemeData
        }else {
            HomeTabData.shared.themeData = themeData
            
            return .success
        }
        
        // 데이터가 비어있는 경우 alert창 띄우기
        
        
        
    }
}

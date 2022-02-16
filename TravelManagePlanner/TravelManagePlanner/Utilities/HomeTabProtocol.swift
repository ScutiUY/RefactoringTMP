//
//  HomeTabProtocol.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/08.
//

import Foundation


// 추천목록에서 선택버튼 클릭시의 함수 정의
// 범용성을 위해 class가 아닌 AnyObject로 선언해준다.
protocol ContentsMainTextDelegate: AnyObject {

// 캘린더 뷰로 전달할 데이터 정의
    func categoryButtonTapped(title: String, place: String, sIdx: Int)
    
}

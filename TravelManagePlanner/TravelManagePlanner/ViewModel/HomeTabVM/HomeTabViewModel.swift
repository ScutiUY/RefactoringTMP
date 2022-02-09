//
//  ThemeViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/05.
//

import Foundation

class HomeTabViewModel {
    //    1 버튼클릭시 해당데이터를 뷰모델에 전달
    //    2 뷰모델은 모델의 데이터를 소지 (Observer는 데이터를 가져오는것이 없기때문에 필요없음)
    //    3 model 에 데이터 최신화
    //    4 Repository내에 model데이터를 Encode하여 데이터 저장
    //    5 Encode된 데이터를 AF(Http Client)를 활용하여 서버에 전달
    
    private var repo = HomeTabRepository()
    private var isLoading: Bool = false
    
    // 상태정의
    var loadingStarted: (() -> ()) = { }
    
    
    // 모델 소유
    private var homeTabData = HomeTabData(themeData: "")
    
    
    
    // VM에서 repository호출, repo에서 api통신 정의
    func register() {
        //        repo.setThemeRepository(homeTabData.themeData ,completed: { HomeTabData in
        //            }) { result in
        //
        //                isLoading = true
        //            switch result {
        //            case .success :
        //                print("성공")
        //                break
        //
        //            case .failure :
        //                print("실패")
        //                break
        //            }
        //        }
        repo.setThemeRepository(homeTabData: homeTabData) { result in
            
            self.isLoading = true
            
            print(result)
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

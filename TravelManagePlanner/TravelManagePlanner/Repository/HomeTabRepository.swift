//
//  HomeTabRepository.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/06.
//

import Foundation


// VM을 통해 담았던 model을 decoding, encoding하여 보관
struct HomeTabRepository {
    
    // api 소지
    let api = HomeTapAPIRequest()
    
    // 테마 데이터 세팅하기(인코딩 변환 및 api통신 호출)
    func setThemeRepository(themeData: ThemeData, completed: @escaping (ThemeData) -> Void) {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(themeData)
            print(jsonData)
            
            // API호출하여 josn데이터 전달
            api.setThemeData(themeData: themeData) { result in
                switch result {
                    
                case .success(let homeTabData) :
                    print("api에 데이터 json전송 성공 : ", homeTabData)
                
                case .failure(let error):
                    print("api에 데이터 json전송 실패 : ", error)
                }//switch
            }
            
        } catch {
            print("homeTabData error in homeTabData repository")
        }
    }
}

// 오류에 대한 정의
extension HomeTabRepository {
    enum repositoryError: Error {
        case basic
        case error(Error)
        case code(Int)
        
        var msg: String {
            switch self {
                   case .basic:
                       return "DEFAULT Error"
                   case .error(let err):
                       return err.localizedDescription
                   case .code(let code):
                       return "\(code) Error"
                   }
        }
    }
}

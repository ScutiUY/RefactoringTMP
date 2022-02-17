//
//  ChangeNameVM.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import Foundation

class ChangeNameViewModel {
    
    private var repo = MypageRepositories()
    
    private var name = ""
    
    var updateCompleted = Observable(false)
    var userInfoInputErrorMessage = Observable("")
    
    func updateUserName(name: String) {
        self.name = name
    }
    
    func validateName() -> ValidationResult {
        if name.count < 2 {
            userInfoInputErrorMessage.value = "이름을 2글자 이상 입력해주세요"
            return .invalidName
        } else {
            return .success
        }
    }
    
    func register() {
        repo.changeName(name: name) { result in
            if result.resCode == "0000" {
                UserData.shared.nickname = self.name
                self.updateCompleted.value = true
            } else {
                self.userInfoInputErrorMessage.value = "업데이트에 실패 하였습니다"
            }
        }
    }
    
}

extension ChangeNameViewModel {
    enum ValidationResult {
        case success
        case invalidName
    }
}

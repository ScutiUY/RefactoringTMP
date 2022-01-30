//
//  SignUpViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/09.
//

import Foundation

enum SignInValidationResult {
    case success
    case invalidEmail
    case invalidPwd
}

class SignUpViewModel {
    private var api = APIRequest()
    
    var userInfoInputErrorMessage: Observable<String> = Observable("")
    var registerSuccess: Observable = Observable(false)
    
    private var userInfo = UserData(email: "", pw: "", name: "") {
        didSet {
            email = userInfo.userEmail
            password = userInfo.userPw
            name = userInfo.name
        }
    }
    
    private var email = ""
    private var password = ""
    private var name = ""
    
    func updateUserEmail(email: String) {
        self.userInfo.userEmail = email
    }
    func updateUserPwd(password: String) {
        self.userInfo.userPw = password
    }
    func updateUserName(name: String) {
        self.userInfo.name = name
    }
    
    func validateUserInformation() -> ValidationResult {
        let regex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._&+-]+@[A-Z0-9a-z.-]+[.]+[A-Za-z]{2,20}", options: NSRegularExpression.Options.caseInsensitive)
        let textToNS = email as NSString
        let emailCheck = regex?.matches(in: email, options: [], range: NSRange(location: 0, length: textToNS.length)).map{textToNS.substring(with: $0.range)}
        
        if emailCheck!.isEmpty || email == "" {
            userInfoInputErrorMessage.value = "이메일을 확인해 주세요"
            return .invalidEmail
        } else if password == "" || password.count < 6 {
            userInfoInputErrorMessage.value = "비밀번호를 확인 해주세요"
            return .invalidPwd
        } else if name == "" {
            userInfoInputErrorMessage.value = "이름을 확인 해주세요"
            return .invalidPwd
        } else if name.count < 2 {
            userInfoInputErrorMessage.value = "이름을 2글자 이상 이"
            return .invalidName
        } else {
            return .success
        }
    }
    
    func register() {
        
        api.signUp(userData: userInfo) { result in
            switch result {
            case .success(let userData):
                print("VM에서 되는",userData)
                self.registerSuccess.value = true
            case .failure(let error):
                self.userInfoInputErrorMessage.value = "네트워크 오류"
                print(error.localizedDescription)
            }
        }
    }
    
}
extension SignUpViewModel {
    enum ValidationResult {
        case success
        case invalidEmail
        case invalidPwd
        case invalidName
    }
}

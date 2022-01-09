//
//  SignInViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit


enum ValidationResult {
    case success
    case invalidEmail
    case invalidPwd
}

class SignInViewModel {
    
    //private let signInData: UserData
    private var api = APIRequest()
    private var userInfo = UserData(email: "", pw: "", name: "") {
        didSet {
            email = userInfo.userEmail!
            password = userInfo.userPw!
            
        }
    }
    
    var userInfoInputErrorMessage: Observable<String> = Observable("")
    var loadingStarted: Observable<Bool> = Observable(false)
    var loadingEnded: Observable = Observable("")
    
    private var email = ""
    private var password = ""
    
    func updateUserEmail(email: String) {
        self.email = email
    }
    func updateUserPwd(password: String) {
        self.password = password
    }
    func inputUserInfo(textField: UITextField) {
        
        print(textField)
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
        } else {
            return .success
        }
    }
    func login() {
        LoginData.shared.email = email
        LoginData.shared.password = password
        api.login(loginData: LoginData.shared)
    }
}

extension SignInViewModel {
    enum userDataStatus {
        case Correct
        case Incorrect
    }
}

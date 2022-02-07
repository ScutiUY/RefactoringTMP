//
//  SignInViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit


class SignInViewModel {
    
    //private let signInData: UserData
    private var api = SignInUpRepository()
    
    private var userInfo = UserData(email: "", pw: "", name: "") {
        didSet {
            email = userInfo.userEmail
            password = userInfo.userPw
            
        }
    }
    
    var userInfoInputErrorMessage: Observable<String> = Observable("")
    var loadingStarted: Observable<Bool> = Observable(false)
    var loadingEnded: Observable = Observable("")
    var loginSuccess: Observable = Observable(false)
    
    private var email = ""
    private var password = ""
    
    func updateUserEmail(email: String) {
        userInfo.userEmail = email
    }
    func updateUserPwd(password: String) {
        userInfo.userPw = password
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
        api.login(loginData: userInfo) { result in
            switch result {
            case .success(let userData):
                print(userData)
                self.loginSuccess.value = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SignInViewModel {
    enum userDataStatus {
        case Correct
        case Incorrect
    }
    enum ValidationResult {
        case success
        case invalidEmail
        case invalidPwd
    }
}

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
    
    var userInfoInputErrorMessage: Observable<String> = Observable("")
    var loadingStarted: Observable<Bool> = Observable(false)
    var loadingEnded: Observable = Observable(false)
    var loginSuccess: Observable = Observable(false)
    
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
        self.loadingStarted.value = true
        api.login(inputId: self.email, inputPw: self.password) { result in
            switch result {
            case .success(let userData):
                print(userData)
                self.loginSuccess.value = true
                self.loadingEnded.value = true
            case .failure(let error):
                print("넘어온 에러", error.localizedDescription)
                self.loginSuccess.value = false
                self.loadingStarted.value = false
                self.loadingEnded.value = true
                
                switch error {
                case .notFoundInDB:
                    self.userInfoInputErrorMessage.value = "계정을 찾을 수 없습니다"
                case .unknown:
                    print("알수 없는 오류")
                case .jsonError:
                    print("Json 오류")
                case .invalidArgument:
                    print("매개변수 오류")
                case .badRequest:
                    print("400")
                case .notFound:
                    print("404")
                case .internalServerError:
                    print("repo error")
                case .omittedParams:
                    print("params error")
                case .ommittedHeader:
                    print("header error")
                case .invalidPw:
                    self.userInfoInputErrorMessage.value = "아이디 및 비밀번호가 일치하지 않습니다, 확인 후 다시 시도해주세요"
                }
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

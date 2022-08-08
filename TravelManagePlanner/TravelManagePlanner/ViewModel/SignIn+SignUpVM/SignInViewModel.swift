//
//  SignInViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation
import UIKit

class SignInViewModel {
    
    enum SignInValidationResult {
        case success
        case invalidEmail
        case invalidPwd
    }

    //private let signInData: UserData
    private var api = APIService()
    
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
        let endpoint = APIEndpoint.signIn(id: "", password: "")
        api.requestData(
            endPoint: endpoint,
            dataType: UserData.self
        ) { result in
            self.loadingStarted.value = false
            self.loadingEnded.value = true
            switch result {
            case .success(let userData):
                UserData.shared = userData
                self.loginSuccess.value = true
            case .failure(let error):
                if let apiError = error as? APIError {
                    self.userInfoInputErrorMessage.value = apiError.errorDescription
                    self.loginSuccess.value = false
                } else {
                    #if DEBUG
                    print(error.localizedDescription, #function)
                    #endif
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

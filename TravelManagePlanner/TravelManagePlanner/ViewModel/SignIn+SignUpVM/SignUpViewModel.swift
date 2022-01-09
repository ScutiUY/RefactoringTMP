//
//  SignUpViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/09.
//

import Foundation

class SignUpViewModel {
    private var api = APIRequest()
    
    var userInfoInputErrorMessage: Observable<String> = Observable("")
    
    private var email = ""
    private var password = ""
    private var name = ""
    func updateUserEmail(email: String) {
        self.email = email
    }
    func updateUserPwd(password: String) {
        self.password = password
    }
    func updateUserName(name: String) {
        self.name = name
    }
    
}

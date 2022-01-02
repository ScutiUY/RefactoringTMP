//
//  SignInViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/03.
//

import Foundation

class SignInViewModel {
    
    //private let signInData: UserData
    
    private var userInfo = UserData(userEmail: "", userPw: "", name: "") {
        didSet {
            username = userInfo.name!
            email = userInfo.userEmail!
            pwd = userInfo.userPw!
            
        }
    }
    
    private var username = ""
    private var email = ""
    private var pwd = ""
    
    
    
}

extension SignInViewModel {
    enum userDataStatus {
        case Correct
        case Incorrect
    }
}

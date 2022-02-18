//
//  DetaileSettingViewModel.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/16.
//

import Foundation

class DetaileSettingViewModel {
    
    private var title = ""
    private var dayToGo = ""
    private var dayToCome = ""
    private var peopleNum = ""
    private var budget = ""
    
    func budgetChangeData(buget: String) -> String{
       
        var returnValue:String = ""
        
        switch buget {
        case "1":
        returnValue = "20"
        case "2":
            returnValue = "40"
        case "3":
            returnValue = "60"
        case "4":
            returnValue = "80"
        default:
            returnValue = "100"
        }
        
        return returnValue
    }
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func updateDate(dayToGo: String, dayToCome: String) {
        self.dayToGo = dayToGo
        self.dayToCome = dayToCome
    }
    
    func updatePeople(peopleNum: String) {
        self.peopleNum = peopleNum
    }
    
    func updateBudget(budget: String) {
        self.budget = budget
    }
    
    
    // 유저입력데이터 유효성
    func validateUserInputData() -> ValidationResult {
        
        guard let a = Int(dayToGo) else { fatalError()}
        guard let b = Int(dayToCome) else { fatalError()}
        
        if title == "" || title.count < 6 {

            return .invalidTitle
        }else if(a > b){
            
            return .invalidDate
        }else if (peopleNum == "") {
            
            return .invalidPeopleNumber
        }else if (budget == "") {
            
            return .invalidBudget
        }else {
            // 디테일설정 데이터 업데이트
            return .success
        }
    }
    
    func register() {
        HomeTabViewModel.globalHomeTabData.title = title
        HomeTabViewModel.globalHomeTabData.startDate = dayToGo
        HomeTabViewModel.globalHomeTabData.endDate = dayToCome
        HomeTabViewModel.globalHomeTabData.inviteNum = peopleNum
        HomeTabViewModel.globalHomeTabData.price = budget
    }
    
}

extension DetaileSettingViewModel {
    enum ValidationResult {
        case success
        case invalidTitle
        case invalidDate
        case invalidPeopleNumber
        case invalidBudget
    }
}

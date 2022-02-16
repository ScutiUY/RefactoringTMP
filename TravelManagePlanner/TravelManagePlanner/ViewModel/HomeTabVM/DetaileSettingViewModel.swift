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
            print("제목을 6글자 이상 입력해주세요")
            
            return .invalidTitle
        }else if(a > b){
            print("가는날의 날짜가 더이전입니다")
            
            return .invalidDate
        }else if (peopleNum == "") {
            print("인원수를 입력해주세요")
            
            return .invalidPeopleNumber
        }else if (budget == "") {
            print("예상 금액을 입력해주세요")
            
            return .invalidPeopleNumber
        }else {
            // 디테일설정 데이터 업데이트
            HomeTabViewModel.globalHomeTabData.title = title
            HomeTabViewModel.globalHomeTabData.startDate = dayToGo
            HomeTabViewModel.globalHomeTabData.endDate = dayToCome
            HomeTabViewModel.globalHomeTabData.inviteNum = peopleNum
            HomeTabViewModel.globalHomeTabData.price = budget
            
            return .success
        }
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

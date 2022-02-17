//
//  ResignViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import Foundation

class ResignViewModel {
    
    private var repo = MypageRepositories()
    
    var resignCompleted = Observable(false)
    
    func resign() {
        repo.resign { result in
            if result.resCode == "0000" {
                self.resignCompleted.value = true
            } else {
                // 예외처리
            }
        }
    }
}

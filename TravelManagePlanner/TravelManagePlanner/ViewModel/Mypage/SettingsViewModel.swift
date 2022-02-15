//
//  SettingsViewModel.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/15.
//

import Foundation

class SettingsViewModel {
    
    private var repo = MypageRepositories()
    
    private var versionData = ""
    
    var dataFetchCompleted = Observable(false)
    
    func getVersionText() -> String {
        return versionData
    }
    
    func getVersionData() {
        repo.getVersion { result in
            self.versionData = result.data.versionName
            self.dataFetchCompleted.value = true
        }
        
    }
}

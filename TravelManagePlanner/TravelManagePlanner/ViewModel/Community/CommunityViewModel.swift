//
//  CommunityViewModel.swift
//  TravelManagePlanner
//
//  Created by Hojin Jang on 2022/02/08.
//

import Foundation

class CommunityViewModel {
    
    private var repo = CommunityDataRepository()
    
    private var communityDataList: CommunityDataList = CommunityDataList.shared
    private var tmpCommunityDataList : CommunityDataList = CommunityDataList.shared
    private var filterCommunityDataList : CommunityDataList = CommunityDataList.shared
    
    var isLoading = false

    
    var loadingStarted: (() -> ()) = { }
    var loadingEnded: (() -> ()) = { }
    var communityUpdated: (() -> ()) = { }
    var failedCommunityDataUpdate: (() -> ()) = { }
    
    func getTitle(index: Int) -> String {
        return communityDataList.communities[index].title
    }
    
    func getHashTags(index: Int) -> String {
        return communityDataList.communities[index].tags
    }
    
    func getimgUrl(index: Int) -> String {
        return communityDataList.communities[index].imgUrl
    }
    
    func communityDataListCount() -> Int {
        return communityDataList.communities.count
    }
    func getCommunity(index: Int) -> CommunityData.CommunityDataDetail {
        return communityDataList.communities[index]
    }
    
    func getFilterList(pickerData data: String) {

        var theme : String
        
        if tmpCommunityDataList.communities.isEmpty {
            self.tmpCommunityDataList = self.communityDataList
        }
        switch data {
        case "연인":
                isLoading = true
                loadingStarted()
                theme = "couple"
            self.filterCommunityDataList.communities = self.tmpCommunityDataList.communities.filter {$0.theme == theme};
        case "친구":
                isLoading = true
                loadingStarted()
                theme = "friend"
            self.filterCommunityDataList.communities = self.tmpCommunityDataList.communities.filter {$0.theme == theme};
        case "가족":
                isLoading = true
                loadingStarted()
                theme = "family"
            self.filterCommunityDataList.communities = self.tmpCommunityDataList.communities.filter {$0.theme == theme};
        case "기타":
                isLoading = true
                loadingStarted()
                theme = "etc"
            self.filterCommunityDataList.communities = self.tmpCommunityDataList.communities.filter {$0.theme == theme};
            default :
                self.getList()
                return;
        }
        self.communityDataList.communities.removeAll()
        self.communityDataList.communities = self.filterCommunityDataList.communities
        self.communityUpdated()
        self.loadingEnded()
        self.isLoading = false
    }
    
    func getList() {
        isLoading = true
        loadingStarted()
        repo.getCommunityData(completed: { result in
            self.communityDataList.communities = result.data
            self.communityUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
    
    func getPersonalList() {
        isLoading = true
        loadingStarted()
        repo.getPersonalCommunityData(completed: { result in
            self.communityDataList.communities = result.data
            self.communityUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
    
    func getSearchList() {
        isLoading = true
        loadingStarted()
        repo.getSearchCommunityData(completed: {
            result in
            self.communityDataList.communities = result.data
            self.communityUpdated()
            self.loadingEnded()
            self.isLoading = false
        })
    }
    
    func putSearWord(word : String) {
        repo.putSearchWord(word: word)
    }
    
}

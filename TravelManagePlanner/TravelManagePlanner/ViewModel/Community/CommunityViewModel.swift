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
    private var isLoading = false
    
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
    func community(index: Int) -> CommunityData.CommunityDataDetail {
        return communityDataList.communities[index]
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
}

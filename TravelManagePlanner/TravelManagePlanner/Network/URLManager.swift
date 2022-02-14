//
//  URLManager.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/10.
//

import Foundation

enum URLManager {
    
    enum Member {
        static var login = "/mmb/checkLogin.tpi"
        static var joinMember = "/mmb/joinMember.tpi"
        static var setUserName = "/mmb/setUserName.tpi"
        static var exitMember = "/mmb/exitMember.tpi"
    }
    
    enum Plan {
        static var getMyTravelList = "/plan/getMyTravelList.tpi"
        static var getTravelDetailinfo = "/plan/getTravelDetailInfo.tpi"
        static var getShopDetailInfo = "/plan/getShopDetailInfo.tpi"
    }
    
}

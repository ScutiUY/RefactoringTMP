//
//  HomeTabAPI.swift
//  TravelManagePlanner
//
//  Created by YoonDaeSung on 2022/02/03.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}


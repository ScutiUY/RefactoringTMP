//
//  NetworkError.swift
//  TravelManagePlanner
//
//  Created by 신의연 on 2022/08/03.
//

import Foundation

enum APIError: Int, Error {
    
    case omittedParams = 9992
    case ommittedHeader = 4444
    case notFoundInDB = 3001
    case invalidPw = 4001
    
    var errorDescription: String {
        switch self {
            
        case .omittedParams:
            return "파라미터 누락"
        case .ommittedHeader:
            return "헤더 누락"
        case .notFoundInDB:
            return "결과를 DB에서 찾을수 없습니다."
        case .invalidPw:
            return "비밀번호 오류"
        }
    }
}

enum NetworkError: Error {
    
    case invalidURL
    case requestFail(Error)
    case invalidResponse
    case failedResponse(statusCode: Int)
    case emptyData
    case decodeError
    
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .requestFail:
            return "HTTP 요청에 실패했습니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .failedResponse(let statusCode):
            return "(\(statusCode)) 실패한 상태코드"
        case .emptyData:
            return "데이터가 없습니다."
        case .decodeError:
            return "디코딩 실패"
        }
    }
}

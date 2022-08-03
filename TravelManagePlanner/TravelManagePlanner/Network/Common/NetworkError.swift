//
//  NetworkError.swift
//  TravelManagePlanner
//
//  Created by 신의연 on 2022/08/03.
//

import Foundation

enum APIError: Int, Error {
    case unknown = -1
    case jsonError = -2
    case invalidArgument = -3
    case badRequest = 400
    case notFound = 404
    case internalServerError = 500
    case omittedParams = 9992
    case ommittedHeader = 4444
    case notFoundInDB = 3001
    case invalidPw = 4001
    
    var errorDescription: String? {
        switch self {
        case .unknown: return "알수 없는 에러입니다."
        case .badRequest: return "request 오류 입니다."
        case .jsonError:
            return "json 에러"
        case .invalidArgument:
            return "유효하지 않은 아규먼트"
        case .notFound:
            return "404 notFound"
        case .internalServerError:
            return "서버 오류"
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

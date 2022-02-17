//
//  MypageRepositories.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/14.
//

import Foundation

class MypageRepositories {
    
    private let httpClient = HttpClient(baseUrl: "https://eunryuplaners.com:19624")
    
    func changeName(name: String, completed: @escaping (PersonalDataResponseData) -> Void) {
        
        let path = URLManager.Member.setUserName
        //let params = ["uKey": UserData.shared.userKey, "userName": name]
        let params = ["uKey": "10000001", "userName": name]
        
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(PersonalDataResponseData.self, from: data)
                    switch decodedData.resCode {
                    case "9992":
                        print(#function, APIError.omittedParams)
                    case "4444":
                        print(#function, APIError.ommittedHeader)
                    case "3001":
                        print(#function, APIError.notFoundInDB)
                    case "4001":
                        print(#function, APIError.invalidPw)
                    default:
                        completed(decodedData)
                    }
                    
                } catch let error as DecodingError {
                    
                    #if DEBUG
                    print("Decoidng \(error) in \(#function)")
                    #endif
                    
                }catch {
                    
                    #if DEBUG
                    print("known error in \(#function)")
                    #endif
                    
                }
                
            case .failure(_):
                #if DEBUG
                print("getJson error in \(#function)")
                #endif
            }
        }
    }
    
    
    func resign(completed: @escaping (PersonalDataResponseData) -> Void) {
        let path = URLManager.Member.exitMember
        //let params = ["uKey": UserData.shared.userKey, "userName": name]
        let params = ["uKey": "10000001"]
        
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(PersonalDataResponseData.self, from: data)
                    switch decodedData.resCode {
                    case "9992":
                        print(#function, APIError.omittedParams)
                    case "4444":
                        print(#function, APIError.ommittedHeader)
                    case "3001":
                        print(#function, APIError.notFoundInDB)
                    case "4001":
                        print(#function, APIError.invalidPw)
                    default:
                        completed(decodedData)
                    }
                    
                } catch let error as DecodingError {
                    
                    #if DEBUG
                    print("Decoidng \(error) in \(#function)")
                    #endif
                    
                }catch {
                    
                    #if DEBUG
                    print("known error in \(#function)")
                    #endif
                    
                }
                
            case .failure(_):
                #if DEBUG
                print("getJson error in \(#function)")
                #endif
            }
        }

    }
    
    func getVersion(completed: @escaping (SettingsResponseData) -> Void) {
        let path = URLManager.Settings.checkingVersion
        //let params = ["uKey": UserData.shared.userKey, "userName": name]
        let params = ["appOsType": "I"]
        
        httpClient.getJsonData(path: path, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(SettingsResponseData.self, from: data)
                    switch decodedData.resCode {
                    case "9992":
                        print(#function, APIError.omittedParams)
                    case "4444":
                        print(#function, APIError.ommittedHeader)
                    case "3001":
                        print(#function, APIError.notFoundInDB)
                    case "4001":
                        print(#function, APIError.invalidPw)
                    default:
                        completed(decodedData)
                    }
                    
                } catch let error as DecodingError {
                    
                    #if DEBUG
                    print("Decoidng \(error) in \(#function)")
                    #endif
                    
                }catch {
                    
                    #if DEBUG
                    print("known error in \(#function)")
                    #endif
                    
                }
                
            case .failure(_):
                #if DEBUG
                print("getJson error in \(#function)")
                #endif
            }
        }

    }
}

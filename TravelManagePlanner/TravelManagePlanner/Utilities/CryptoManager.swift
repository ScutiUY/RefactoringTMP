//
//  CryptoManager.swift
//  TravelManagePlanner
//
//  Created by 신의연 on 2022/08/09.
//

import Foundation
import CommonCrypto

struct CryptoManager {
    static var shared = CryptoManager()
    
    private init() {}
    
    func convertToSHA256String(with text: String) -> String {
        if let stringData = text.data(using: String.Encoding.utf8) {
            return makeSDataToSHA256String(with: stringData)
        }
        return ""
    }
    
    private func makeSDataToSHA256String(with data: Data) -> String {
        return hexStringFromData(input: digest(input: data as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

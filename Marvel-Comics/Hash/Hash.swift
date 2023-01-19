//
//  Hash.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 19.01.23.
//

import Foundation
import CommonCrypto

class Hash {
    
    static func MD5(str: String) -> String {
        if let strData = str.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
            
            let _ = strData.withUnsafeBytes {
                CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            var md5String = ""
            for byte in digest {
                md5String += String(format:"%02x", UInt8(byte))
            }
            
            return md5String
            
        }
        return ""
    }
}

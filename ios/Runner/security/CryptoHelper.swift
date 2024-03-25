import Foundation
import CommonCrypto


class CryptoHelper {
    
    func encrypt(text: String, key: String, iv: String) throws -> String? {
        let keyData = key.data(using: .utf8)!
        let ivData = iv.data(using: .utf8)!
        let inputData = text.data(using: .utf8)!
        
        var encryptedBytes = [UInt8] (repeating: 0, count: (inputData.count + kCCBlockSizeAES128))
        var encryptedLength = 0
        
        let status = keyData.withUnsafeBytes { keyBytes in
            ivData.withUnsafeBytes { ivBytes in
                inputData.withUnsafeBytes { inputBytes in
                    CCCrypt(
                        CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, keyData.count,
                        ivBytes.baseAddress,
                        inputBytes.baseAddress, inputData.count,
                        &encryptedBytes,
                        encryptedBytes.count,
                        &encryptedLength
                    )
                }
            }
        }
        
        guard status == kCCSuccess else {
            throw NSError(domain: "crypto", code: Int(status))
        }
        
        let encryptedData = Data(bytes: &encryptedBytes, count: encryptedLength)
        return encryptedData.base64EncodedString()
    }
    
    func descrypt(encryptedText: String, key: String, iv: String) throws -> String? {
        let keyData = key.data(using: .utf8)!
        let ivData = iv.data(using: .utf8)!
        let inputData = Data(base64Encoded: encryptedText)!
        
        var decryptedBytes = [UInt8] (repeating: 0, count: (inputData.count + kCCBlockSizeAES128))
        var decryptedLength = 0
        
        let status = keyData.withUnsafeBytes { keyBytes in
            ivData.withUnsafeBytes { ivBytes in
                inputData.withUnsafeBytes { inputBytes in
                    CCCrypt(
                        CCOperation(kCCDecrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, keyData.count,
                        ivBytes.baseAddress,
                        inputBytes.baseAddress, inputData.count,
                        &decryptedBytes,
                        decryptedBytes.count,
                        &decryptedLength
                    )
                }
            }
        }
        
        guard status == kCCSuccess else {
            throw NSError(domain: "crypto", code: Int(status))
        }
        
        return String(bytes: decryptedBytes.prefix(decryptedLength), encoding: .utf8)
    }
}

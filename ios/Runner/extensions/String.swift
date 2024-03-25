//
//  String.swift
//  Runner
//
//  Created by RAPHAEL DOS SANTOS MARACAIPE on 14/03/24.
//

import Foundation

extension String {
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
}

//
//  Regex.swift
//  Runner
//
//  Created by RAPHAEL DOS SANTOS MARACAIPE on 12/03/24.
//

import Foundation

class Regex {
    
    func generate(pattern: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return ""
        }
        
        let randomString = randomStringOfLength(20)
        let range = NSRange(location: 0, length: randomString.utf16.count)
        
        let generatedString = regex.stringByReplacingMatches(in: randomString, range: range, withTemplate: "")
        return generatedString
    }
    
    private func randomStringOfLength(_ length: Int) -> String {
       let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
       return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

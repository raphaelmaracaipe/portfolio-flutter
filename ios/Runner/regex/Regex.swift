//
//  Regex.swift
//  Runner
//
//  Created by RAPHAEL DOS SANTOS MARACAIPE on 12/03/24.
//

import Foundation

class Regex {
    
    func generate(pattern: String) -> String {
        do {
            let size = sizeExtractedOfPattern(inputString: pattern)
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let allowedCharacters = "0123456789ABCDEFGHJKLMNPQRSTUWXYZabcdefghijkmnopqrstuvwxyz"
            var result = ""
            
            while result.isEmpty || regex.numberOfMatches(in: result, options: [], range: NSRange(location: 0, length: result.utf16.count)) == 0 {
                result = String((0..<size).map { _ in allowedCharacters.randomElement()! })
            }
            
            return result
        } catch {
            print("Erro ao criar expressão regular: \(error)")
            return ""
        }
    }
    
    private func sizeExtractedOfPattern(inputString: String) -> Int {
        guard let firstIndex = inputString.firstIndex(of: "{") else {
            return 0
        }
        guard let lestIndex = inputString.firstIndex(of: "}") else {
            return 0
        }
        
        let textReplaced = String(inputString[firstIndex..<lestIndex]).replacingOccurrences(of: "{", with: "")
        return Int(textReplaced) ?? 0
    }
    
}

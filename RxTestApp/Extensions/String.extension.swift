//
//  String.extension.swift
//  RxTestApp
//
//  Created by HINOMORI HIROYA on 2018/06/20.
//  Copyright © 2018年 HINOMORI HIROYA. All rights reserved.
//

import Foundation

extension String : AppExtensionCompatible { }

extension AppExtension where Base == String {

    private func decodeNumeric(_ string : String, base : Int) -> Character? {
        guard let code = UInt32(string, radix: base),
            let uniScalar = UnicodeScalar(code) else { return nil }
        return Character(uniScalar)
    }
    
    private func decode(_ entity : String) -> Character? {
        
        if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
            let start = entity.index(entity.startIndex, offsetBy: 3)
            let end = entity.index(entity.endIndex, offsetBy: -1)
            return decodeNumeric(String(entity[start ..< end]), base: 16)
        } else if entity.hasPrefix("&#") {
            let start = entity.index(entity.startIndex, offsetBy: 2)
            let end = entity.index(entity.endIndex, offsetBy: -1)
            return decodeNumeric(String(entity[start ..< end]), base: 10)
        } else {
            switch entity {
            case "&quot;":  return "\""
            case "&amp;":   return "&"
            case "&apos;":  return "'"
            case "&lt;":    return "<"
            case "&gt;":    return ">"
            case "&nbsp;":  return "\u{00a0}"
            case "&diams;": return "♦"
            default: return nil
            }
        }
    }
    
    func decodeHTMLEntities() -> String {
        
        var result = ""
        var position = base.startIndex
        
        while let ampRange = base.range(of: "&", range: position ..< base.endIndex) {
            result.append(String(base[position ..< ampRange.lowerBound]))
            position = ampRange.lowerBound
            
            if let semiRange = base.range(of: ";", range: position ..< base.endIndex) {
                let entity = base[position ..< semiRange.upperBound]
                position = semiRange.upperBound
                
                if let decoded = decode(String(entity)) {
                    result.append(decoded)
                } else {
                    result.append(String(entity))
                }
            } else {
                break
            }
        }
        result.append(String(base[position ..< base.endIndex]))
        return result
    }

}


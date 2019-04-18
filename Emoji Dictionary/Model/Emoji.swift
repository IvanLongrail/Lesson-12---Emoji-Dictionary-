//
//  Emoji.swift
//  Emoji Dictionary
//
//  Created by Denis Bystruev on 11/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//
import Foundation

class Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    var encode: Data? {
        let encoder = PropertyListEncoder()
        
        return try? encoder.encode(self)
    }
    
    init(symbol: String = "", name: String = "", description: String = "", usage: String = "") {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}

// MARK: - Init From Decoded Data
extension Emoji {
    
    convenience init?(from data: Data) {
        let decoder = PropertyListDecoder()
        
        guard let currentEmoji = try? decoder.decode(Emoji.self, from: data) else { return nil }
        
        self.init(symbol: currentEmoji.symbol, name: currentEmoji.name, description: currentEmoji.description, usage: currentEmoji.usage)
    }
}

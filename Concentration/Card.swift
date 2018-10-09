//
//  Card.swift
//  Concentration
//
//  Created by Yacov Uziel on 13/09/2018.
//  Copyright © 2018 Yacov Uziel. All rights reserved.
//

import Foundation

struct Card{
    
    var isFaceUp:Bool
    var isMatched:Bool
    var identifier: Int
    
    static var uniqueIdentifier = 0
    
    static func getNextIdentifier() -> Int{
        uniqueIdentifier += 1
        return uniqueIdentifier
    }
    
    init() {
        self.isFaceUp = false
        self.isMatched = false
        self.identifier = Card.getNextIdentifier()
    }
}

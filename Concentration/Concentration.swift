//
//  Concentration.swift
//  Concentration
//
//  Created by Yacov Uziel on 13/09/2018.
//  Copyright © 2018 Yacov Uziel. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var numberOfFlips = 0
    
    var score = 0
    
    var cardsLeft = 0
    
    var historyOfChoices = [Int]()
    
    var startTime: Date?
    
    func chooseCard(atIndex index: Int){
        numberOfFlips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { // 2 different cards were selected
                if cards[matchIndex].identifier == cards[index].identifier { // we've got a match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    cardsLeft -= 2
                    if startTime != nil { // give 3 points bonus in case the player found a match in under 2 seconds
                        let duration = Date().timeIntervalSince(startTime!)
                        checkIfUserQuickEnough(start: duration)
                    }
                }
                else {
                    if historyOfChoices.contains(index) {
                         score -= 1
                    }
                    if (historyOfChoices.contains(matchIndex)) {
                        score -= 1
                    }
                    historyOfChoices.append(index)
                    historyOfChoices.append(matchIndex)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                startTime = Date()
            }
        }
    }
    
    func checkIfUserQuickEnough(start duration: Double) {
        if duration < 2 {
            score += 3
        }
    }
    
    init (numberOfPairs: Int){
        for _ in 1...numberOfPairs {
            let card = Card()
            cards.append(card)
            cards.append(card) //for matching card
        }
        
        //shuffle the cards        
        for _ in cards.indices {
            let firstRandomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let secondRandomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(firstRandomIndex, secondRandomIndex)
        }
        cardsLeft = cards.count
    }
    
    func getFlipCounter() -> Int {
        return numberOfFlips
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getCardsLeft() -> Int {
        return cardsLeft
    }
    
    func startNewGame() {
        historyOfChoices.removeAll()
        score = 0
        numberOfFlips = 0
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }
    }
    
    func exitGame() {
        exit(0)
    }
}

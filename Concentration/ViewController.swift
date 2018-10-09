//
//  ViewController.swift
//  Concentration
//
//  Created by Yacov Uziel on 12/09/2018.
//  Copyright © 2018 Yacov Uziel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairs: (buttons.count + 1) / 2)
    @IBOutlet weak var flipCounter: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairs: (buttons.count + 1) / 2)
        game.startNewGame()
        updateUI()
        emojiThemesTemp = emojiThemes
        randomThemeIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let touchedCardIdx = buttons.index(of: sender){
            game.chooseCard(atIndex: touchedCardIdx)
            updateUI()
            if game.getCardsLeft() == 0 {
                endGame()
            }
        }
        else{
            print("error")
        }
    }
    
    func endGame() {
        let alert = UIAlertController(title: "", message: "Congratulations! You Won!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Exit", style: UIAlertActionStyle.default, handler: {action in self.game.exitGame()}))
        alert.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.default, handler: {action in self.newGame(UIButton())}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUI() {
        flipCounter.text = "Flips: \(game.getFlipCounter())"
        scoreLabel.text = "Score: \(game.getScore())"
        
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                if card.isMatched { // card needs to disappear
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                }
                else {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
                
            }
        }
    }
    
    var emojiThemes = [0: ["👻","🎃","👽","🤡","🦇","👺"], 1:["⚽️","🏀","🏈","⚾️","🎾","🏐"], 2:["🐳","🐙","🐝","🐮","🦖","🐒"], 3:["🚗","🚌","✈️","🚲","🏎","🚢"], 4:["🇦🇷","🇨🇦","🇧🇷","🇺🇸","🇮🇱","🇭🇰"], 5:["🍎","🍋","🍉","🍆","🥝","🌽"]]
    
    lazy var randomThemeIndex = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    
    var emoji = [Int:String]()
    
    lazy var emojiThemesTemp = emojiThemes
    
    func getEmoji (for card: Card) -> String {
        if let emojiChoices = emojiThemesTemp[randomThemeIndex] {
            if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                    let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                    emoji[card.identifier] = emojiThemesTemp[randomThemeIndex]!.remove(at: randomIndex)
            }
        }
        return emoji[card.identifier] ?? "?"
    }



}


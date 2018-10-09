//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Yacov Uziel on 09/10/2018.
//  Copyright © 2018 Yacov Uziel. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    //bad design but is good for the demo
//    let themes = ["Sports" : "⚽️🏀🏈⚾️🎾🏐",
//                  "Animals": "🐳🐙🐝🐮🦖🐒",
//                  "Flags": "🇦🇷🇨🇦🇧🇷🇺🇸🇮🇱🇭🇰"]
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = themeName
                }                
            }
        }
    }


}

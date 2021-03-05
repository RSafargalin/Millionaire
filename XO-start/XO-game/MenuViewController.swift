//
//  MenuViewController.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 28.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case Navigation.startGameWithTwoPlayers:
            Game.manager.preparationFor(.twoPlayers)
        
        case Navigation.startGameWithComputer:
            Game.manager.preparationFor(.computer)
            
        case Navigation.startDelayedGame:
            Game.manager.preparationFor(.delayedStart)
            
        default:
            break
        }
    }

}

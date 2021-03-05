//
//  ExecutionMovesState.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 03.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class ExecutionMovesState: GameState {
    
    
    var isMoveCompleted: Bool = false
    private var gameViewControllerDelegate: GameStateControlDelegate
    private var gameboardViewDelegate: GameboardViewUserInteractionDelegate
    
    init(gameViewControllerDelegate: GameStateControlDelegate, gameboardViewDelegate: GameboardViewUserInteractionDelegate){
        self.gameViewControllerDelegate = gameViewControllerDelegate
        self.gameboardViewDelegate = gameboardViewDelegate
    }
    
    func begin() {
        gameboardViewDelegate.userInteraction(false)
        Game.manager.execute { (result) in
            Game.manager.isDetermineWinnerNow = result
            self.isMoveCompleted = result
            self.gameboardViewDelegate.userInteraction(true)
            self.gameViewControllerDelegate.nextState()
        }
    }
    
    func addMark(at position: GameboardPosition) {}
    
}

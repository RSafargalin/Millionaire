//
//  GameCommand.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 04.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameCommand {
    
    let player: Player
    let position: GameboardPosition
    private weak var gameboard: Gameboard?
    private weak var gameboardView: GameboardView?
    
    init(player: Player, position: GameboardPosition, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.position = position
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func execute() {
        
        guard let gameboard = gameboard, let gameboardView = gameboardView else { return }

        gameboard.setPlayer(player, at: position)
        
        if !gameboardView.canPlaceMarkView(at: position) {
            gameboardView.removeMarkView(at: position)
        }
        
        gameboardView.placeMarkView(player.markViewPrototype.copy(), at: position)
        
    }
    
}

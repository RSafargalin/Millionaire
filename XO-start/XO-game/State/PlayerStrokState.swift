//
//  PlayerStrokState.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 03.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class PlayerStrokState: GameState {
    
    public let player: Player
    public let markViewPrototype: MarkView
    
    private var gameViewControllerDelegate: GameDelegate
    
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?
    
    var isMoveCompleted: Bool = false
    var strokeCounter: Int = 0
    
    init(player: Player, gameViewControllerDelegate: GameDelegate, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewControllerDelegate = gameViewControllerDelegate
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        let delegate = gameViewControllerDelegate as! PlayersLabelControlDelegate
        delegate.showLabelFor(player)
        delegate.showResultLabel(false)
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position), let gameboard = gameBoard else {
            return
        }
        
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
            
        let command = GameCommand(player: player, position: position, gameboard: gameboard, gameboardView: gameBoardView)
        
        Game.manager.addCommand(command, for: player)
        
        strokeCounter += 1
        
        if strokeCounter >= 5 {
            isMoveCompleted = true
            turnIsOver(for: player)
        }
    }
    
    private func turnIsOver(for player: Player) {
        switch player {
        case .first:
            Game.manager.firstPlayersTurnIsOver = true
            
        case .second:
            Game.manager.secondPlayersTurnIsOver = true
            
        default:
            break
        }
    }
    
}

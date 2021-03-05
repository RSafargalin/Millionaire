//
//  StrategyProtocol.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 28.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class Game {
    
    static let manager = Game()
    private init() {}
    
    var isPlayingWithСomputer: Bool = false
    var isDetermineWinnerNow: Bool = true
    var isDelayedStartGame: Bool = false
    
    var firstPlayersTurnIsOver: Bool = false
    var secondPlayersTurnIsOver: Bool = false
    
    var delegate: PlayersLabelControlDelegate?
    
    enum GameMode {
        case twoPlayers,
             computer,
             delayedStart
    }
    
    private var firstPlayerCommands: [GameCommand] = []
    private var secondPlayerCommands: [GameCommand] = []
    private lazy var commands: [GameCommand] = zip(self.firstPlayerCommands, self.secondPlayerCommands).flatMap{[$0, $1]}
    
    func addCommand(_ command: GameCommand, for player: Player) {
        switch player {
        case .first:
            firstPlayerCommands.append(command)
            
        case .second:
            secondPlayerCommands.append(command)
            
        default:
            break
        }
    }
    
    func execute(completion: @escaping (Bool) -> ()) {
        for (index, command) in commands.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(index) + 0.25) {
                command.execute()
                self.delegate?.showLabelFor(command.player)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(commands.count) + 1.25) {
            completion(true)
        }
    }
    
    func preparationFor(_ gamemode: GameMode) {
        switch gamemode {
        case .twoPlayers:
            isPlayingWithСomputer = false
            isDelayedStartGame = false
            isDetermineWinnerNow = true
            
        case .computer:
            isPlayingWithСomputer = true
            isDelayedStartGame = false
            isDetermineWinnerNow = true
            
        case .delayedStart:
            isPlayingWithСomputer = false
            isDelayedStartGame = true
            isDetermineWinnerNow = false
            firstPlayersTurnIsOver = false
            secondPlayersTurnIsOver = false
        }
    }
}

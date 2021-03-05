//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.manager.delegate = self
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
//            self.gameboardView.placeMarkView(XView(), at: position)
            
            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                
                self.counter += 1
                
                self.setNextState()
            }
        }
    }
    
    @IBAction func backToMenuDidTap(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        Log(action: .restartGame)
        
        if Game.manager.isDelayedStartGame {
            Game.manager.preparationFor(.delayedStart)
        } else if Game.manager.isPlayingWithСomputer {
            Game.manager.preparationFor(.computer)
        } else {
            Game.manager.preparationFor(.twoPlayers)
        }
        
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
    }
    
    private func setFirstState() {
        counter = 0
        let player = Player.first
        if Game.manager.isDelayedStartGame {
            currentState = PlayerStrokState(player: player, gameViewControllerDelegate: self,
                                   gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        } else {
            currentState = PlayerState(player: player, gameViewController: self,
                                   gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        }
    }
    
    private func setNextState() {
        
        if let winner = referee.determineWinner() {
            if Game.manager.isDetermineWinnerNow {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            }
        } else {
            if Game.manager.firstPlayersTurnIsOver && Game.manager.secondPlayersTurnIsOver && Game.manager.isDetermineWinnerNow {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
        }
        
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self)
            return
        }
        
        if Game.manager.firstPlayersTurnIsOver && Game.manager.secondPlayersTurnIsOver {
            gameboardView.clear()
            currentState = ExecutionMovesState(gameViewControllerDelegate: self, gameboardViewDelegate: gameboardView)
            return
        }
        
        
        if let playerInputState = currentState as? PlayerState {
            
            let player = playerInputState.player.next
            currentState = PlayerState(player: player, gameViewController: self,
                                       gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
            if player == .computer {
                computerStroke()
            }
            
        }
        
        if let playerStrokState = currentState as? PlayerStrokState {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gameboardView.clear()
                let player = playerStrokState.player.next
                self.currentState = PlayerStrokState(player: player, gameViewControllerDelegate: self,
                                                     gameBoard: self.gameBoard, gameBoardView: self.gameboardView, markViewPrototype: player.markViewPrototype)
            }
            
        }
    }
    
    private func computerStroke() {
        gameboardView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var canPlaceMarkView = false
            var position = GameboardPosition(column: 0, row: 0)
            repeat {
                let column = Int.random(in: 0...(GameboardSize.columns - 1))
                let row = Int.random(in: 0...(GameboardSize.rows - 1))
                position = GameboardPosition(column: column, row: row)
                canPlaceMarkView = self.gameboardView.canPlaceMarkView(at: position)
                
            } while !canPlaceMarkView
            self.currentState.addMark(at: position)
            self.counter += 1
            self.gameboardView.isUserInteractionEnabled = true
            self.setNextState()
        }
    }
}

extension GameViewController: GameStateControlDelegate {
    func nextState() {
        setNextState()
    }
}

extension GameViewController: PlayersLabelControlDelegate {
    func showLabelFor(_ player: Player) {
        switch player {
        case .first:
            firstPlayerTurnLabel.isHidden = false
            secondPlayerTurnLabel.isHidden = true
        case .second, .computer:
            firstPlayerTurnLabel.isHidden = true
            secondPlayerTurnLabel.isHidden = false
        }
    }
    
    func showResultLabel(_ state: Bool) {
        winnerLabel.isHidden = !state
    }
}

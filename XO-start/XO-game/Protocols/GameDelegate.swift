//
//  GameDelegate.swift
//  XO-game
//
//  Created by Ruslan Safargalin on 05.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameDelegate {}

protocol GameStateControlDelegate: GameDelegate {
    func nextState()
}

protocol GameboardViewUserInteractionDelegate: GameDelegate {
    func userInteraction(_ state: Bool)
}

protocol PlayersLabelControlDelegate {
    func showLabelFor(_ player: Player)
    
    func showResultLabel(_ state: Bool)
}

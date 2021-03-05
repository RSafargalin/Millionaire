//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    
    
    var next: Player {
        switch self {
        case .first where Game.manager.isPlayingWithСomputer == false:
            return .second
            
        case .first where Game.manager.isPlayingWithСomputer == true:
            return .computer
        
        case .second, .computer:
            return .first
            
        case .first:
            return .second
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second, .computer:
            return OView()
        }
    }
}

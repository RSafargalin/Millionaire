//
//  GameSession.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import Foundation

final class GameSession {
    
    // MARK: Variables
    
    var correctAnswerCount: Double = 0
    var questionsCount: Double = 0
    lazy var winPercentage: Double = correctAnswerCount / questionsCount * 100
    
}

extension GameSession: GameViewDelegate {
    
    func fetchGameStats(answers: Double, questions: Double) {
        self.correctAnswerCount = answers
        self.questionsCount = questions
    }
    
}

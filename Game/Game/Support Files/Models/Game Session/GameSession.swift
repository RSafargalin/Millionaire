//
//  GameSession.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import Foundation

final class GameSession {
    
    // MARK: Variables
    
    lazy var winPercentage: Double = correctAnswerCount.value / questionsCount.value * 100
    
    var questionsCount: Observable<Double> = Observable(0.0)
    var correctAnswerCount: Observable<Double> = Observable(0.0)
}

extension GameSession: GameViewDelegate {
    
    func fetchGameStats(answers: Double, questions: Double) {
        self.correctAnswerCount.value = answers
        self.questionsCount.value = questions
    }
    
}

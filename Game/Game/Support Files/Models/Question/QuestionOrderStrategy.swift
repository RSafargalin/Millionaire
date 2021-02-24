//
//  QuestionOrderStrategy.swift
//  Game
//
//  Created by Ruslan Safargalin on 22.02.2021.
//

import Foundation

protocol QuestionOrderStrategy {
    func getQuestions() -> [Question]
}

class QuestionsInRandomOrder: QuestionOrderStrategy {
    
    func getQuestions() -> [Question] {
        return Game.default.questions.shuffled()
    }
    
}

class QuestionsInDirectOrder: QuestionOrderStrategy {
    
    func getQuestions() -> [Question] {
        return Game.default.questions
    }
    
}


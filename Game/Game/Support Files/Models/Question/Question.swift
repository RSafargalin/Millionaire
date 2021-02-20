//
//  Question.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import Foundation

// Создайте структуру Question, содержащую сам вопрос, варианты ответа и правильный ответ.

struct Question {
    
    // MARK: Variables
    
    let question: String
    
    let answers: [Int:String]
    
    let correctAnswer: Int
}

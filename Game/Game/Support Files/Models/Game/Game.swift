//
//  Game.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import Foundation

final class Game {
    
    // MARK: Singleton init
    
    static let `default` = Game()
    private init() {
        self.results = self.caretaker.retrieveResults()
    }
    
    // MARK: Variables
    
    var gameSession: GameSession?
    private let caretaker = GameResultCaretaker()
    
    typealias WinPercentage = Double
    
    private(set) var results: [GameResult] {
        didSet {
            caretaker.save(records: self.results)
        }
    }
    
    var questions: [Question] = []
    
    private var defaultsQuestions: [Question] = [
        Question(question: "В каком году Титаник утонул в Атлантическом океане 15 апреля во время своего первого плавания из Саутгемптона?",
                 answers: [1 : "1912",
                           2 : "1911",
                           3 : "1913",
                           4 : "1915"],
                 correctAnswer: 1),
        
        Question(question: "Какова продолжительность жизни стрекозы?",
                 answers: [1 : "28 ч.",
                           2 : "12 ч.",
                           3 : "24 ч.",
                           4 : "48 ч."],
                 correctAnswer: 3),
        
        Question(question: "Дата рождения Николы Тесла?",
                 answers: [1 : "15 июня 1857",
                           2 : "10 июля 1856",
                           3 : "9 августа 1855",
                           4 : "11 декабря 1856"],
                 correctAnswer: 2),
        
        Question(question: "Дата основания Уфы?",
                 answers: [1 : "1623 г.",
                           2 : "1582 г.",
                           3 : "1720 г.",
                           4 : "1574 г."],
                 correctAnswer: 4),
        
        Question(question: "Дата основания Праги?",
                 answers: [1 : "VIII век",
                           2 : "VII век",
                           3 : "IV век ",
                           4 : "VI век"],
                 correctAnswer: 1)
    ]
    
    // MARK: Enums
    
    enum Navigation {
        static let menu = "backToMenu",
                   game = "initGame",
                   result = "goToResult",
                   score = "score"
    }
    
    enum GameErrors: Error {
        case questionsAreOver
    }
    
    enum Questions {
        case defaults,
             new([Question]?)
    }
    
    // MARK: Methods
    
    func addResult(message: String) -> GameResult {
        let result = GameResult()
        result.questionsCount = gameSession?.questionsCount ?? 0
        result.correctAnswerCount = gameSession?.correctAnswerCount ?? 0
        result.winPercentage = gameSession?.winPercentage ?? 0
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        let date: String = dateFormatter.string(from: currentDate)
        
        result.date = date
        result.message = message
        results.append(result)
        return result
    }
    
    func fetchNextQuestion() -> Result<Question, GameErrors> {
        if questions.count > 0 {
            return .success(questions.removeFirst())
        } else {
            return .failure(.questionsAreOver)
        }
    }
    
    func reloadQuestions(from questions: Questions) {
        switch questions {
        case .defaults:
            self.questions = defaultsQuestions
            
        case .new(let questions):
            guard let questions = questions, !questions.isEmpty
            else {
                self.questions = defaultsQuestions
                return
            }
            self.questions = questions
        }
    }
}

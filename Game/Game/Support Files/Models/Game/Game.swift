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
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
    
    typealias WinPercentage = Double
    
    private(set) var results: [GameResult] {
        didSet {
            caretaker.save(records: self.results)
        }
    }
    
    var questions: [Question] = [] {
        didSet {
            //print("Questions ", questions)
        }
    }
    
    var strategy: QuestionOrderStrategy = QuestionsInDirectOrder()
    
    // MARK: Enums
    
    enum Navigation {
        static let menu = "backToMenu",
                   game = "initGame",
                   result = "goToResult",
                   score = "score",
                   settings = "settings",
                   addQuestion = "addQuestion"
    }
    
    enum GameErrors: Error {
        case questionsAreOver
    }
    
    enum QuestionsType {
        case defaults,
             new([Question]?),
             users
    }
    
    // MARK: Methods

    func addResult(state: GameViewController.GameEndState) -> GameResult {
        
        let result = GameResult()
        result.questionsCount = gameSession?.questionsCount.value ?? 0
        result.correctAnswerCount = gameSession?.correctAnswerCount.value ?? 0
        result.winPercentage = gameSession?.winPercentage ?? 0
        
        let date: String = dateFormatter.string(from: Date())
        result.date = date
        
        result.isVictory = state == .victory ? true : false
        
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
    
    func reloadQuestions(from questionsType: QuestionsType) {
        switch questionsType {
        case .defaults:
            self.questions = Questions().defaults
            
        case .new(let questions):
            guard let questions = questions, !questions.isEmpty
            else {
                self.questions = Questions().defaults
                return
            }
            self.questions = questions
            
        case .users:
            let userQuestitons = Questions().userQuestions
            guard !userQuestitons.isEmpty
            else {
                self.questions = Questions().defaults
                return
            }
            self.questions = userQuestitons + Questions().defaults
        }
        
        questions = self.strategy.getQuestions()
    }
}

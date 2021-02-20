//
//  ResultView.swift
//  Game
//
//  Created by Ruslan Safargalin on 20.02.2021.
//

import UIKit

final class ResultView: UIView {
    
    // MARK: UBOutlets
    
    @IBOutlet weak var endGameState: UILabel! 
    @IBOutlet weak var questionsCount: UILabel!
    @IBOutlet weak var answersCount: UILabel!
    @IBOutlet weak var winPercentage: UILabel!
    
    // MARK: Methods
    
    func setup(result: GameResult) {
        endGameState.text = result.message
        endGameState.textColor = result.message == "You lose!" ? .red : .green
        questionsCount.text = "Question count: \(String(format: "%0.f", result.questionsCount))"
        answersCount.text = "Answers count: \(String(format: "%0.f", result.correctAnswerCount))"
        winPercentage.text = "Win percentage: \(result.winPercentage)%"
    }
}

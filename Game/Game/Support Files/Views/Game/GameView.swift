//
//  GameView.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import UIKit

final class GameView: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var stats: UILabel!
    
    // MARK: Variables
    
    var correctAnswerID: Int?
    
    // MARK: Methods
    
    func setup(_ question: Question) {
        self.question.text = question.question
        question.answers.forEach { (answer) in
            answerButtons[answer.key - 1].setTitle(answer.value, for: .normal)
        }
        correctAnswerID = question.correctAnswer
    }
}

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
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    // MARK: Variables
    
    var correctAnswer: String?
    
    // MARK: Methods
    
    func setup(_ question: Question) {
        self.question.text = question.question
        let answers = [answerButton1, answerButton2, answerButton3, answerButton4]
        question.answers.forEach { (answer) in
            answers[answer.key - 1]?.setTitle(answer.value, for: .normal)
        }
        correctAnswer = question.answers[question.correctAnswer]
    }
}

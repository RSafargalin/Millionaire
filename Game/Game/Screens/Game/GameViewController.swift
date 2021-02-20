//
//  GameViewController.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import UIKit

protocol GameViewDelegate {
    func fetchGameStats(answers: Double, questions: Double) 
}

class GameViewController: UIViewController {

    // MARK: Variables
    
    lazy var contentView = view as! GameView
    
    private var correctAnswerCount: Double = 0
    private var questionsCount: Double = 0
    
    var delegate: GameViewDelegate?
    
    // MARK: Enums
    
    private enum PossibleAnswer {
        case correctly,
             wrong
    }
    
    private enum GameEndState {
        case victory,
             defeat
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: IBAction
    
    @IBAction private func answerButtonsTap(_ sender: UIButton) {
        guard let currentAnswer = sender.currentTitle,
              let correctAnswer = contentView.correctAnswer else { return }
        
        if currentAnswer == correctAnswer {
            playerAnswered(.correctly)
            
            let question = Game.default.fetchNextQuestion()
            switch question {
            case .success(let question):
                contentView.setup(question)
                
            case .failure( _):
                endGame(.victory)
            }
            
        } else {
            playerAnswered(.wrong)
            endGame(.defeat)
        }
    }
    
    // MARK: Methods
    
    private func playerAnswered(_ answer: PossibleAnswer) {
        switch answer {
        case .correctly:
            correctAnswerCount += 1
            questionsCount += 1
            
        case .wrong:
            questionsCount += 1
        }
        delegate?.fetchGameStats(answers: correctAnswerCount, questions: questionsCount)
    }
    
    private func endGame(_ state: GameEndState) {
        var sender = ""
        
        switch state {
        case .victory:
            sender = "You win!"
            
        case .defeat:
            sender = "You lose!"
        }
        let result = Game.default.addResult(message: sender)
        performSegue(withIdentifier: Game.Navigation.result, sender: result)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Game.Navigation.result:
            guard let controller = segue.destination as? ResultViewController,
                  let result = sender as? GameResult
            else { return }
            
            controller.contentView.setup(result: result)
            Game.default.gameSession = nil
                    
        default:
            break
        }
        
    }
    
}

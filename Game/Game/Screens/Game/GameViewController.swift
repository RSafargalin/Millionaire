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
    var globalQuestionsCount: Double = 1
    
    var delegate: GameViewDelegate?
    
    // MARK: Enums
    
    private enum PossibleAnswer {
        case correctly,
             wrong
    }
    
    enum GameEndState {
        case victory,
             defeat
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectGameStatsObserver()
    }
    
    // MARK: IBAction
    
    @IBAction private func answerButtonsTap(_ sender: UIButton) {
        guard let correctAnswerID = contentView.correctAnswerID else { return }
        
        if sender.tag == correctAnswerID {
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
    
    private func connectGameStatsObserver() {
        let stats = contentView.stats
        Game.default.gameSession?.questionsCount.addObserver(stats!,
                                                             options: [.initial, .new],
                                                             closure:
        { [weak self] (value, change) in
            let correctAnswerCount = Game.default.gameSession?.correctAnswerCount.value ?? 0.0
            let gameProgress = correctAnswerCount / (self?.globalQuestionsCount ?? 1.0) * 100
            
            stats?.text = "Question: \(Int(value) + 1) \nGame progress: \(gameProgress.rounded())%"
        })
    }
    
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
        let result = Game.default.addResult(state: state)
        Game.default.gameSession = nil
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
                    
        default:
            break
        }
        
    }
    
}

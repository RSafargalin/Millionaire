//
//  ViewController.swift
//  Game
//
//  Created by Ruslan Safargalin on 19.02.2021.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: Variables
    
    lazy var contentView = view as! MenuView
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Game.Navigation.game:
            guard let controller = segue.destination as? GameViewController else { return }
            
            Game.default.gameSession = GameSession()
            controller.delegate = Game.default.gameSession
            
            Game.default.reloadQuestions(from: .users)
            controller.globalQuestionsCount = Double(Game.default.questions.count)
            let question = Game.default.fetchNextQuestion()
            
            switch question {
            case .success(let question):
                controller.contentView.setup(question)
                
            default:
                break
            }
            
            navigationController?.setNavigationBarHidden(true, animated: false)
            
        default:
            break
        }
    }
}


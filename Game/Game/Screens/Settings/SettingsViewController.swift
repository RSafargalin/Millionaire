//
//  SettingsViewController.swift
//  Game
//
//  Created by Ruslan Safargalin on 22.02.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBAction func randomOrderQuestionsSwitchValueChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            Game.default.strategy = QuestionsInRandomOrder()
            
        case false:
            Game.default.strategy = QuestionsInDirectOrder()
        }
    }
}

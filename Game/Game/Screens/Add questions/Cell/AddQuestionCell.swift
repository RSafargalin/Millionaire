//
//  AddQuestionCell.swift
//  Game
//
//  Created by Ruslan Safargalin on 23.02.2021.
//

import UIKit

class AddQuestionCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var questionField: RSTextField!
    @IBOutlet var answers: [RSTextField]!
    @IBOutlet weak var correctAnswerSwitch: RSSegmentedControl!
    
}

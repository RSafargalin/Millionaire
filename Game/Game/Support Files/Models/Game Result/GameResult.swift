//
//  Results.swift
//  Game
//
//  Created by Ruslan Safargalin on 20.02.2021.
//

import Foundation

final class GameResult: Codable {

    // MARK: Variables
    var date: String = ""
    var correctAnswerCount: Double = 0
    var questionsCount: Double = 0
    var winPercentage: Double = 0
    var message: String = ""
}

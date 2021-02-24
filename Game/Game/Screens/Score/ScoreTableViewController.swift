//
//  Score.swift
//  Game
//
//  Created by Ruslan Safargalin on 20.02.2021.
//

import UIKit

final class ScoreTableViewController: UITableViewController {
    
    var records: [GameResult] = Game.default.results.reversed()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let record = records[indexPath.item]
        cell.textLabel?.text = record.message
        cell.textLabel?.textColor = record.isVictory == false ? .red : .green
        cell.detailTextLabel?.text = "\(record.date) \n    Answers: \(String(format: "%0.f", record.correctAnswerCount)) \n    Questions: \(String(format: "%0.f", record.questionsCount)) \n    Win percentage: \(record.winPercentage.rounded())%"
        cell.selectionStyle = .none
        return cell
    }
}

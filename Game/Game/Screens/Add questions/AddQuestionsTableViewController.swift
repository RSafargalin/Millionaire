//
//  AddQuestionsTableViewController.swift
//  Game
//
//  Created by Ruslan Safargalin on 23.02.2021.
//

import UIKit

final class AddQuestionsTableViewController: UIViewController {
    
    var questions: [Question] = []
    let builder: QuestionsBuilder = QuestionsBuilder()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addQuestionsButtonContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addQuestionDidTap(_ sender: UIButton) {
        let question = Question(question: "", answers: [1 : "", 2 : "", 3 : "", 4 : ""], correctAnswer: 0)
        questions.append(question)
        let item = questions.count
        let indexPath = IndexPath(item: item - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func saveQuestionsDidTap(_ sender: UIBarButtonItem) {
        guard let navigationController = navigationController else { return }
        
        var questions = Questions()
        questions.userQuestions = questions.userQuestions + builder.build()
        
        navigationController.popToRootViewController(animated: true)
    }
    
    @objc func answerChange(_ textField: RSTextField) {
        guard let text = textField.text else { return }
        builder.setAnswerText(text: text, question: textField.value, answer: textField.tag)
    }
    
    @objc func questionChange(_ textField: RSTextField) {
        guard let text = textField.text else { return }
        builder.setQuestions(text: text, question: textField.value)
    }
    
    @objc func correctAnswerChange(_ swith: RSSegmentedControl) {
        builder.setCorrectAnswers(question: swith.value, answer: swith.selectedSegmentIndex)
    }
    
}

extension AddQuestionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddQuestionCell
        
        if !questions.isEmpty {
            let currentQuestion = questions[indexPath.item]
            
            cell.questionField.text = currentQuestion.question
            cell.answers.forEach { (answer) in
                answer.text = currentQuestion.answers[answer.tag]
            }
            cell.correctAnswerSwitch.selectedSegmentIndex = currentQuestion.correctAnswer
        } else {
            cell.questionField.text = ""
            cell.answers.forEach { (answer) in
                answer.text = ""
            }
            cell.correctAnswerSwitch.selectedSegmentIndex = 0
        }
        
        cell.answers.forEach { (answer) in
            answer.addTarget(self, action: #selector(answerChange), for: .editingChanged)
            answer.value = indexPath.item
        }
        cell.questionField.addTarget(self, action: #selector(questionChange), for: .editingChanged)
        cell.questionField.value = indexPath.item
        
        cell.correctAnswerSwitch.addTarget(self, action: #selector(correctAnswerChange), for: .valueChanged)
        cell.correctAnswerSwitch.value = indexPath.item
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460.0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? AddQuestionCell else { return }
        var answers: [Int : String] = [:]
        
        let questionText = cell.questionField.text ?? ""
        cell.answers.forEach { (answer) in
            answers.updateValue(answer.text ?? "", forKey: answer.tag)
        }
        let correctAnswer = cell.correctAnswerSwitch.selectedSegmentIndex
        
        let question = Question(question: questionText, answers: answers, correctAnswer: correctAnswer)
        questions[indexPath.item] = question
    }
    
}

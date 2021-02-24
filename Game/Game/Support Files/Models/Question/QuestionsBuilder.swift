//
//  QuestionsBuilder.swift
//  Game
//
//  Created by Ruslan Safargalin on 23.02.2021.
//

import Foundation

final class QuestionsBuilder {
    
    private(set) var questionsText: [Int : String] = [:]
    
    private(set) var answersN1: [Int : String] = [:]
    private(set) var answersN2: [Int : String] = [:]
    private(set) var answersN3: [Int : String] = [:]
    private(set) var answersN4: [Int : String] = [:]
    
    private(set) var correctAnswers: [Int : Int] = [:]
    
    enum AnswersNumber: Int {
        case first = 1,
             second,
             theThird,
             fourth
    }
    
    enum Errors: Error {
        case emptyAnswer
    }
    
    func build() -> [Question] {
        var questions: [Question] = []
        
        for index in 0...questionsText.count {
            
            guard let text = questionsText[index], !text.isEmpty else { continue }
            
            var answers: [Int : String] = [:]
            
            do {
                var answer: String = try getAnswer(.first, for: index)
                answers.updateValue(answer, forKey: 1)
                
                answer = try getAnswer(.second, for: index)
                answers.updateValue(answer, forKey: 2)
                
                answer = try getAnswer(.theThird, for: index)
                answers.updateValue(answer, forKey: 3)
               
                answer = try getAnswer(.fourth, for: index)
                answers.updateValue(answer, forKey: 4)
            } catch  {
                continue
            }
            
            let correctAnswer = correctAnswers[index]
            
            let question = Question(question: text, answers: answers, correctAnswer: correctAnswer ?? 1)
            questions.append(question)
        }
        
        return questions
    }
    
    func setQuestions(text: String, question number: Int) {
        guard !text.isEmpty else { return }
        questionsText.updateValue(text, forKey: number)
    }
    
    func setAnswerText(text: String, question number: Int, answer id: Int) {
        guard !text.isEmpty else { return }
        setAnswer(AnswersNumber(rawValue: id)!, for: number, text: text)
    }
    
    func setCorrectAnswers(question number: Int, answer id: Int) {
        correctAnswers.updateValue(id + 1, forKey: number)
    }
    
    private func setAnswer(_ number: AnswersNumber, for question: Int, text: String) {
        switch number {
        case .first:
            answersN1.updateValue(text, forKey: question)
            
        case .second:
            answersN2.updateValue(text, forKey: question)
            
        case .theThird:
            answersN3.updateValue(text, forKey: question)
            
        case .fourth:
            answersN4.updateValue(text, forKey: question)
        }
    }
    
    private func getAnswer(_ number: AnswersNumber, for question: Int) throws -> String {
        switch number {
        case .first:
            guard let answer = answersN1[question], !answer.isEmpty else { throw Errors.emptyAnswer}
            return answer
            
        case .second:
            guard let answer = answersN2[question], !answer.isEmpty else { throw Errors.emptyAnswer}
            return answer
            
        case .theThird:
            guard let answer = answersN3[question], !answer.isEmpty else { throw Errors.emptyAnswer}
            return answer
            
        case .fourth:
            guard let answer = answersN4[question], !answer.isEmpty else { throw Errors.emptyAnswer}
            return answer
        }
    }
    
}

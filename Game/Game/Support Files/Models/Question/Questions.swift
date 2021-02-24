//
//  Questions.swift
//  Game
//
//  Created by Ruslan Safargalin on 21.02.2021.
//

import Foundation

struct Questions {
    
    private let caretaker = UserQuestionsCaretaker()
    
    init() {
        self.userQuestions = caretaker.retrieveQuestions()
    }
    
    var userQuestions: [Question] {
        didSet {
            caretaker.save(records: self.userQuestions)
        }
    }
    
    private(set) var defaults: [Question] = [
        Question(question: "В каком году Титаник утонул в Атлантическом океане 15 апреля во время своего первого плавания из Саутгемптона?",
                 answers: [1 : "1912",
                           2 : "1911",
                           3 : "1913",
                           4 : "1915"],
                 correctAnswer: 1),
        
        Question(question: "Какова продолжительность жизни стрекозы?",
                 answers: [1 : "28 ч.",
                           2 : "12 ч.",
                           3 : "24 ч.",
                           4 : "48 ч."],
                 correctAnswer: 3),
        
        Question(question: "Дата рождения Николы Тесла?",
                 answers: [1 : "15 июня 1857",
                           2 : "10 июля 1856",
                           3 : "9 августа 1855",
                           4 : "11 декабря 1856"],
                 correctAnswer: 2),
        
        Question(question: "Дата основания Уфы?",
                 answers: [1 : "1623 г.",
                           2 : "1582 г.",
                           3 : "1720 г.",
                           4 : "1574 г."],
                 correctAnswer: 4),
        
        Question(question: "Дата основания Праги?",
                 answers: [1 : "VIII век",
                           2 : "VII век",
                           3 : "IV век ",
                           4 : "VI век"],
                 correctAnswer: 1)
    ]
}

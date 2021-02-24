//
//  UserQuestionsCaretaker.swift
//  Game
//
//  Created by Ruslan Safargalin on 24.02.2021.
//

import Foundation

class UserQuestionsCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "questions"
    typealias Memento = Data
    
    func save(records: [Question]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}

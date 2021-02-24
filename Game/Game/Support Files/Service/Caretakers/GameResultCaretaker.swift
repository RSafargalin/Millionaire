//
//  GameCaretaker.swift
//  Game
//
//  Created by Ruslan Safargalin on 20.02.2021.
//

import Foundation

class GameResultCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "records"
    typealias Memento = Data
    
    func save(records: [GameResult]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [GameResult] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([GameResult].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    public enum Error: Swift.Error {
        case gameNotFound
    }
}

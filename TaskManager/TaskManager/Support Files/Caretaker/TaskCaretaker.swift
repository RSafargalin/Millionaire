//
//  TaskCaretaker.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 08.03.2021.
//

import Foundation

class TaskCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "task"
    typealias Memento = Data
    
    func save(records: [Task]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            
            let oldTask = try self.decoder.decode([Task].self, from: data)
            
            var tasks: [Task] = []
            oldTask.forEach { (task) in
                if let compositeTask = task as? CompositeTask {
                    tasks.append(compositeTask)
                } else if let concreteTask = task as? ConcreteTask {
                    tasks.append(concreteTask)
                }
            }
            return tasks
        } catch {
            print(error)
            return []
        }
    }
}

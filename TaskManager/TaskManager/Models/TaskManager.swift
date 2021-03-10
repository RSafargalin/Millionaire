//
//  TaskManager.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 08.03.2021.
//

import Foundation

final class TaskManager {
    let caretaker = TaskCaretaker()
    
    static let main = TaskManager()
    private init() {
        self.tasks = self.caretaker.retrieveTasks()
    }
    
    var tasks: [Task] {
        didSet {
            caretaker.save(records: tasks)
        }
    }
    
    var lastTaskId: Int {
        return tasks.count
    }
    
    enum TaskTypes {
        case concrete,
             composite
    }
    
    func createTask(_ type: TaskTypes, name: String) -> Task {
        switch type {
        case .concrete:
            let task = ConcreteTask(id: lastTaskId, name: name)
            tasks.append(task)
            return task
            
        case .composite:
            let task = CompositeTask(id: lastTaskId, name: name)
            tasks.append(task)
            return task
        }
    }
    
}

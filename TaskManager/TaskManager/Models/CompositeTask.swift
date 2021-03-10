//
//  CompositeTask.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 07.03.2021.
//

import Foundation



final class CompositeTask: Task {
    
    var tasks: [Task] = []
    
    override init(id: Int, name: String) {
        super.init(id: id, name: name)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    override func execute() {
        print("Task \(name) executing")
        if !tasks.isEmpty {
            tasks.forEach { $0.execute() }
        }
        print("Task \(name) completed")
    }
    
}

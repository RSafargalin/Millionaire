//
//  Task.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 07.03.2021.
//

import Foundation

class ConcreteTask: Task {
    
    override init(id: Int, name: String) {
        super.init(id: id, name: name)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func execute() {
        print("Task \(name) completed")
    }
    
}

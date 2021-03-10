//
//  TaskProtocol.swift
//  TaskManager
//
//  Created by Ruslan Safargalin on 07.03.2021.
//

import Foundation

protocol TaskProtocol {
    var id: Int { get set }
    var name: String { get set }
    func execute()
}

class Task: TaskProtocol, Codable {
    
    var id: Int = 0
    var name: String = ""
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func execute() {
        
    }
}

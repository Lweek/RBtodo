//
//  Todo.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation


/// Represent one todo in list.
struct Todo: Codable, Identifiable {
    
    /// Todo identification.
    let id: Int
    
    /// User identification.
    let userID: Int
    
    /// User readable todo title.
    let title: String?
    
    /// Completion status.
    var completed: Bool = false

    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
    
    
    // MARK: - UI Testing
    
    
    static var dummy: Todo {
        Todo(id: 1, userID: 1, title: "Test todo", completed: false)
    }

    static var dummyCompleted: Todo {
        Todo(id: 1, userID: 1, title: "Test todo", completed: true)
    }
}

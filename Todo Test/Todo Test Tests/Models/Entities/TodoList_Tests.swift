//
//  TodoList_Tests.swift
//  Todo Test Tests
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import XCTest
@testable import Todo_Test

class TodoList_Tests: XCTestCase {
        
    private var list = TodoList(todos: [])
    
    
    override func setUp() {
        super.setUp()
        
        list = TodoList(todos: [])
    }
    

    func testValues() throws {
        XCTAssertEqual(list.todos.count, 0)
    }
    
    
    func testMutatingValues() throws {
        // When
        list.todos.append(Todo(id: 1, userID: 1, title: "Test"))

        // Then
        XCTAssertEqual(list.todos.count, 1)
        
        // When
        list.todos.append(Todo(id: 2, userID: 1, title: "Test"))

        // Then
        XCTAssertEqual(list.todos.count, 2)
        
        // When
        list.todos.removeAll()

        // Then
        XCTAssertEqual(list.todos.count, 0)
    }

}

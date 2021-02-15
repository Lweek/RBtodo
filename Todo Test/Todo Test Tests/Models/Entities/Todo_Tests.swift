//
//  Todo_Tests.swift
//  Todo Test Tests
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import XCTest
@testable import Todo_Test

class Task_Tests: XCTestCase {
    
    
    func testValues() throws {
        let task = Todo(id: 1, userID: 2, title: "Test", completed: true)
        
        XCTAssertEqual(task.id, 1)
        XCTAssertEqual(task.userID, 2)
        XCTAssertEqual(task.title, "Test")
        XCTAssertTrue(task.completed)
    }

    
    func testDefaultValues() throws {
        let task = Todo(id: 1, userID: 2, title: "Test")
        
        XCTAssertFalse(task.completed)
    }
    
    
    func testMutatingValues() throws {
        // Given
        var task = Todo(id: 1, userID: 2, title: "Test")
        
        // When
        task.completed = false
        
        // Then
        XCTAssertFalse(task.completed)
        
        // When
        task.completed = true
        
        // Then
        XCTAssertTrue(task.completed)
    }

}

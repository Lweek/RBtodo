//
//  TodoRequest.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation
import os

/// Retrieve one given todo.
struct TodoRequest: APIRequest {
    
    /// Todo identifier.
    var id: Int
    
    private var baseURL: URL {
        apiURL.appendingPathComponent("todos")
    }
    
    var request: URLRequest {
        let url = baseURL.appendingPathComponent(String("\(id)"))
        os_log(.debug, "One task url: %@", url.absoluteString)
        return URLRequest(url: url)
    }
    
}

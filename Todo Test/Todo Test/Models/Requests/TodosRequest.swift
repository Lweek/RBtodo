//
//  TodosRequest.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation
import os

/// Retrieve all todos.
struct TodosRequest: APIRequest {
    
    private var baseURL: URL {        
        apiURL.appendingPathComponent("todos")
    }
    
    var request: URLRequest {
        os_log(.debug, "Tasks URL: %@", baseURL.absoluteString)
        return URLRequest(url: baseURL)
    }
    
}

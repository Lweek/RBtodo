//
//  APIRequest.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation

protocol APIRequest {
        
    /// Network request.
    var request: URLRequest { get }
    
}

extension APIRequest {
    
    /// Base API URL.
    var apiURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
}

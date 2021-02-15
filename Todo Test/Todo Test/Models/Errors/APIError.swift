//
//  APIError.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import Foundation

enum APIError: Error, Equatable {
    case decodingError
    case errorCode(Int)
    case unknown
}

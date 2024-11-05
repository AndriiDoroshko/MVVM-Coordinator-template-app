//
//  NetworkError.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(String)
    case nerworkError(String)
    case noDataRecived(String)
    case decodingJSONError(String)
    case cancelled
    
    var message: String {
        switch self {
        case .invalidURL(let message):
            return message
        case .nerworkError(let message):
            return message
        case .noDataRecived(let message):
            return message
        case .decodingJSONError(let message):
            return message
        case .cancelled:
            return "Network request was canceled"
        }
    }
}

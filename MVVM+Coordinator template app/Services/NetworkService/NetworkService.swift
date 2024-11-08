//
//  NetworkService.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getData(query: String,
                 completion: @escaping (Result<String, NetworkError>) -> ())
    func downloadImage(from urlString: String,
                       completion: @escaping (Result<UIImage, NetworkError>) -> ())
}


class NetworkService: NetworkServiceProtocol {
    var searchDataTask: URLSessionDataTask?
    var downloadImageDataTask: URLSessionDataTask?
    
    deinit {
        // Making sure all network tasks are cenceled when ViewModel setting refrence counter to 0
        searchDataTask?.cancel()
        downloadImageDataTask?.cancel()
    }
    
    func getData(query: String,
                 completion: @escaping (Result<String, NetworkError>) -> ()) {
        let formattedQuery
        = query.replacingOccurrences(of: " ", with: ",")
        
        let urlString
        = NetworkURLs.urlString + formattedQuery
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL("Invalid URL.")))
            return
        }
        
        searchDataTask?.cancel()
        searchDataTask
        = URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                // Handle errors
                if let error = error {
                    switch error.localizedDescription {
                    case "cancelled":
                        completion(.failure(NetworkError.cancelled))
                    default:
                        completion(.failure(NetworkError.nerworkError(error.localizedDescription)))
                    }
                    return
                }
                
                // Check for valid response and data
                guard let data = data else {
                    completion(.failure(NetworkError.noDataRecived("No data received.")))
                    return
                }
                
                // Decode the JSON response
                do {
//                    let object = try JSONDecoder().decode(Object.self, from: data)
//                    completion(.success(object))
                } catch {
                    completion(.failure(NetworkError.decodingJSONError(error.localizedDescription)))
                }
            }
        
        // Start the network task
        searchDataTask?.resume()
    }
    
    func downloadImage(from urlString: String,
                       completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL("")))
            return
        }
        
        downloadImageDataTask?.cancel()
        
        downloadImageDataTask
        = URLSession
            .shared
            .dataTask(with: url) { data, response, error in
            if let error = error {
                switch error.localizedDescription {
                case "cancelled":
                    completion(.failure(NetworkError.cancelled))
                default:
                    completion(.failure(NetworkError.nerworkError(error.localizedDescription)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataRecived("Data is missing in response")))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(NetworkError.decodingJSONError("Data recived is not an image")))
                return
            }
            completion(.success(image))
        }
        downloadImageDataTask?.resume()
    }
}

//
//  HomeViewModel.swift
//  MVVM+Coordinator template app
//
//  Created by Andrey Doroshko on 11/5/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func refreshData()
    func loading(_ isLoading: Bool)
    func displayError(_ message: String)
}

class HomeViewModel {
    
    weak var coordinator: HomeCoordinator?
    weak var viewDelegate: HomeViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    
    init(viewDelegate: HomeViewModelDelegate,
         networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        self.viewDelegate = viewDelegate
    }
    
    func networkError(_ error: NetworkError) {
        switch error {
        case .cancelled:
            print("HomeScreenViewModel Error: \(error.message)")
        default:
            viewDelegate?.displayError(error.message)
        }
    }
}

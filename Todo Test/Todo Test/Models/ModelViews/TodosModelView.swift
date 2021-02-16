//
//  TodosModelView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import Foundation
import Combine
import SwiftUI

class TodosModelView: ObservableObject {
    
    enum State {
        case loading
        case ready
        case failure
    }
    
    
    let api: API
    
    init(api: API) {
        self.api = api
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var state: State = .loading {
        didSet {
            print("STATE: \(state)")
        }
    }
    
    @Published var todos = [Todo]()

    func getTodos() {
        
        state = .loading
        
        let publisher: AnyPublisher<[Todo], APIError> = api.fetch(request: TodosRequest())
        
        let cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    self?.state = .ready
                case .failure(_):
                    self?.state = .failure
                }
            } receiveValue: { todos in
                self.todos = todos
            }
        
        self.cancellables.insert(cancellable)
    }
    
}

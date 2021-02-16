//
//  AddTodoModelView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import Foundation
import SwiftUI
import Combine

class AddTodoModelView: ObservableObject {
    
    @Published var userID: Int = 0
    @Published var title: String = ""
    @Published var completed: Bool = false
    
    
    init() {
        configureValidation()
    }
    
    
    // MARK: - Validation
    
    @Environment(\.maxTodoTitleLength) var maxTodoTitleLength
    
    typealias ValidatePublisher = AnyPublisher<Bool, Never>
    
    enum TitleValidation {
        case empty
        case tooLong
        case valid
    }
    
    /// Eventual error description for title validation.
    @Published var titleValidationMessage = ""
    
    /// Describe if current values are valid and so saving can proceed.
    @Published var isValid: Bool = false
    
    private var cancellableSet = Set<AnyCancellable>()
    
    private var isTitleEmptyPublisher: ValidatePublisher {
        $title
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isTitleTooLongPublisher: ValidatePublisher {
        $title
            .removeDuplicates()
            .map { [unowned self] in
                $0.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).count > self.maxTodoTitleLength
            }
            .eraseToAnyPublisher()
    }
    
    private var isTitleValidPublisher: AnyPublisher<TitleValidation, Never> {
        Publishers
            .CombineLatest(isTitleEmptyPublisher, isTitleTooLongPublisher)
            .map { isEmpty, isTooLong in
                if isEmpty { return .empty }
                if isTooLong { return .tooLong }
                return .valid
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: ValidatePublisher {
        isTitleValidPublisher
            .map { $0 == .valid }
            .eraseToAnyPublisher()
    }
    
    
    /// Connect all validators together and bind them.
    private func configureValidation() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .map { $0 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
        
        isTitleValidPublisher
            .receive(on: DispatchQueue.main)
            .map { state in
                switch state {
                case .tooLong: return NSLocalizedString(
                    "todo-title-too-long",
                    comment: "Title length is too long"
                )
                default: return ""
                }
            }
            .assign(to: \.titleValidationMessage, on: self)
            .store(in: &cancellableSet)
    }
    
    
    // MARK: - Saving
    
    enum SavingError: Error {
        case notImplemented
        case notValidData
    }
    
    /// Save current todo if possible.
    /// - Parameter completion: Callback called after successful save operation.
    /// - Throws: Saving error description.
    func saveTodo(completion: () -> Void) throws {
        guard isValid else { throw SavingError.notValidData }
        
        let todo = Todo(id: nil, userID: userID, title: title, completed: completed)
        
        // FIXME: Implement real save        
        throw SavingError.notImplemented
        
        completion()
    }
    
}

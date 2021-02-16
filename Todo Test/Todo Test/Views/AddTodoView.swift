//
//  AddTodoView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI
import Combine

struct AddTodoView: View {
    
    
    typealias CompletionHandler = () -> Void
        
    /// Is done button is disabled?
    @State var isDoneDisabled: Bool = true
    
    /// Is failure alert dialog presented?
    @State var isAlertPresented: Bool = false
    
    @StateObject var addTodoModelView = AddTodoModelView()
    
    /// Completion callback performed before leaving view.
    var completion: CompletionHandler?
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("todo-user", selection: $addTodoModelView.userID) {
                        ForEach(0..<10) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                }
                Section(header: Text("todo"), footer: Text(addTodoModelView.titleValidationMessage).foregroundColor(.red)) {
                    TextField("todo-title", text: $addTodoModelView.title)
                    Toggle("todo-completed", isOn: $addTodoModelView.completed)
                }
            }
            .navigationTitle("add-todo")
            .navigationBarItems(
                leading: Button(action: {
                    completion?()
                }, label: {
                    Text("cancel").fontWeight(.regular)
                }),
                trailing: Button("done") {
                    do {
                        try addTodoModelView.saveTodo {
                            completion?()
                        }
                    } catch AddTodoModelView.SavingError.notImplemented {
                        isAlertPresented = true
                    } catch {
                        // FIXME: react to all kind of problems
                    }
                }.disabled(!addTodoModelView.isValid)
            )
            .alert(isPresented: $isAlertPresented, content: {
                Alert(
                    title: Text("error"),
                    message: Text("save-not-available"),
                    dismissButton: .default(Text("ok")) {  }
                )
            })
            
        }
    }
    
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}

//
//  MainView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var todosModelView: TodosModelView
    
    /// Is Add Todo view presented?
    @State var isAddTodoPresented = false
    
    var body: some View {
        NavigationView {
            switch todosModelView.state {
            case .loading: LoadingView()
            case .failure: FailureView() {
                todosModelView.getTodos()
            }
            case .ready:
            TodoListView()
                .navigationTitle("main-title")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            isAddTodoPresented.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("add-todo")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }
                        })
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                }
                .sheet(isPresented: self.$isAddTodoPresented) {
                    AddTodoView() {
                        isAddTodoPresented.toggle()
                    }
                }
            }
        }
        .onAppear {
            todosModelView.getTodos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        MainView()
            .environmentObject(TodosModelView(api: API(session: URLSession.shared)))
    }
}

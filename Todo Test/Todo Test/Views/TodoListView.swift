//
//  TodoListView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var todosModelView: TodosModelView
    
    var body: some View {
        List(todosModelView.todos) { todo in
            TodoView(todo: todo) {
                // TODO: update todo state
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct TodoListView_Previews: PreviewProvider {
        
    static var previews: some View {
        Group {
            TodoListView()
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .environmentObject(TodosModelView(api: API(session: URLSession.shared)))
        }
    }
}

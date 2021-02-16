//
//  TodoView.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 16.02.2021.
//

import SwiftUI

struct TodoView: View {
    
    typealias ToggleHandler = () -> Void
    
    let todo: Todo
    
    let handler: ToggleHandler
    
    var body: some View {
        HStack {
            Image(systemName: todo.completed ? "checkmark.square.fill" : "square")
                .foregroundColor(.accentColor)
            Text(todo.title ?? "")
                .font(.body)
                .padding(.horizontal, 10)
            Spacer()
        }
        .padding(.vertical, 10)
        .onTapGesture {
            handler()
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoView(todo: Todo.dummy) {}
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        
            TodoView(todo: Todo.dummyCompleted) {}
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
            
            TodoView(todo: Todo.dummy) {}
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                
        
            TodoView(todo: Todo.dummyCompleted) {}
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}

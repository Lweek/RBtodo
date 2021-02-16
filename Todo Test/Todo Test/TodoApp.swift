//
//  TodoApp.swift
//  Todo Test
//
//  Created by Vladimir Belohradsky on 15.02.2021.
//

import SwiftUI

@main
struct TodoApp: App {
    
    @ObservedObject var todosModelView: TodosModelView
    
    init() {
        todosModelView = TodosModelView(api: API(session: URLSession.shared))
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(todosModelView)
        }
    }
}

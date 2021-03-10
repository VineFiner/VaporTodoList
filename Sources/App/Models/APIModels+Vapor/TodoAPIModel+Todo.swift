//
//  File.swift
//  
//
//  Created by Finer  Vine on 2021/3/10.
//

import Foundation
import Vapor

extension TodoAPIModel: Content { }

extension TodoAPIModel {
    init(todo: Todo) throws {
        try self.init(id: todo.requireID(), title: todo.title)
    }
}

extension TodoAPIModel.Create {
    func makeTodo() -> Todo {
        Todo(title: title)
    }
}

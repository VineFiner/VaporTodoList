import Fluent
import Vapor

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let todos = routes.grouped("api", "todos")
        todos.get(use: index)
        todos.post(use: create)
        todos.group(":todoID") { todo in
            todo.get(use: getSingleHandler)
            todo.delete(use: delete)
        }
    }
    
    func index(req: Request) throws -> EventLoopFuture<[TodoAPIModel]> {
        return Todo.query(on: req.db)
            .all()
            .flatMapThrowing { (todos) -> [TodoAPIModel] in
                try todos.map({ (todo) -> TodoAPIModel in
                    try TodoAPIModel.init(todo: todo)
                })
            }
    }
    
    func getSingleHandler(req: Request) throws -> EventLoopFuture<TodoAPIModel> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing(TodoAPIModel.init)
    }
    
    func create(req: Request) throws -> EventLoopFuture<TodoAPIModel> {
        let create = try req.content.decode(TodoAPIModel.Create.self)
        let todo = create.makeTodo()
        
        return todo.save(on: req.db)
            .flatMapThrowing {
                try TodoAPIModel(todo: todo)
            }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}

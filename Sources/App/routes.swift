import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index.html", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("site", "todos") { req in
        return req.view.render("todo.html")
    }
    
    try app.register(collection: TodoController())
    try app.register(collection: MetricsController())
}

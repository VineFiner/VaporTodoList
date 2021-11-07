import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req -> String in
        let time = Date()
        return "Date:\t\(time)\nTimeStamp:\t\(time.timeIntervalSince1970*1000)"
    }
    
    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    // http://127.0.0.1:8080/site
    app.get("site") { req in
        return req.view.render("leaf/index", ["title": "Hello Vapor!"])
    }
    
    // http://127.0.0.1:8080/site/vue2
    app.get("site", "vue2") { req in
        return req.view.render("vue2/index.html")
    }
    
    // http://127.0.0.1:8080/site/vue3
    app.get("site", "vue3") { req in
        return req.view.render("vue3/index.html", ["title": "Hello Vapor!"])
    }
    
    /* http://127.0.0.1:8080/site/vite
     * 单页面应用, 配置路由根目录 `site/vite`
     * npm run build
     */
    app.get("site", "vite") { req in
        return req.view.render("vite/index.html")
    }
    
    try app.register(collection: TodoController())
    try app.register(collection: MetricsController())
}

import Fluent
import FluentSQLiteDriver
import Prometheus
import SystemMetrics
import Metrics
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // metrics
    let myProm = PrometheusMetricsFactory(client: PrometheusClient())
    let prometheus = SystemMetrics.Configuration(
        labels: .init(
            prefix: "process_",
            virtualMemoryBytes: "virtual_memory_bytes",
            residentMemoryBytes: "resident_memory_bytes",
            startTimeSeconds: "start_time_seconds",
            cpuSecondsTotal: "cpu_seconds_total",
            maxFds: "max_fds",
            openFds: "open_fds"
        )
    )
    MetricsSystem.bootstrapWithSystemMetrics(myProm, config: prometheus)
    
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    
    app.migrations.add(CreateTodo())
    
    app.views.use(.leaf)
    
    if app.environment == .development {
        try app.autoMigrate().wait()
    }
    // register routes
    try routes(app)
}

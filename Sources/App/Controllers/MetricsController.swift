//
//  File.swift
//  
//
//  Created by Finer  Vine on 2021/5/27.
//

import Foundation
import Metrics
import Vapor

struct MetricsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let metrics = routes.grouped("api", "metrics")
        metrics.get(use: index(req:))
        metrics.get("counter", use: metricsCounter(req:))
        metrics.get("cpu", use: cpuStatus(req:))
    }
    
    /// http://127.0.0.1:8080/api/metrics
    func index(req: Request) throws -> EventLoopFuture<String> {
        let promise = req.eventLoop.makePromise(of: String.self)
        DispatchQueue.global().async {
            do {
                let promInstance = try MetricsSystem.prometheus()
                promInstance.collect(into: promise)
            } catch {
                promise.fail(error)
            }
        }
        return promise.futureResult
    }
    
    /// http://127.0.0.1:8080/api/metrics/cpu
    func cpuStatus(req: Request) throws -> EventLoopFuture<String> {
        let promise = req.eventLoop.makePromise(of: String.self)
        DispatchQueue.global().async {
            do {
                try MetricsSystem.prometheus().collect(into: promise)
            } catch {
                promise.fail(error)
            }
        }
        return promise.futureResult
    }
    
    // http://127.0.0.1:8080/api/metrics/counter
    func metricsCounter(req: Request) throws -> EventLoopFuture<String> {
        let promise = req.eventLoop.makePromise(of: String.self)
        DispatchQueue.global().async {
            do {
                let promInstance = try MetricsSystem.prometheus()
                let counter = promInstance.createCounter(forType: Int.self, named: "my_counter")
                counter.inc()
                promise.succeed("1")
            } catch {
                promise.fail(error)
            }
        }
        return promise.futureResult
    }
}

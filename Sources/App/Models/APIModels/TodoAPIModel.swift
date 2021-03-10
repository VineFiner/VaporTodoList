//
//  File.swift
//  
//
//  Created by Finer  Vine on 2021/3/10.
//

import Foundation

struct TodoAPIModel: Codable {
    public let id: UUID
    public let title: String

    public init(id: UUID, title: String) {
      self.id = id
      self.title = title
    }
}

extension TodoAPIModel {
    struct Create: Codable {
        let title: String
        
        init(title: String) {
            self.title = title
        }
    }
}

//
//  LogList.swift
//  pillz
//
//  Created by viraltaco_ on 20200103.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation
import CoreData

struct LogList: Codable & Writable {
  static let defaultPath = Defaults.logsFile
  var list: [Log]
  
// MARK: coding keys
  enum CodingKeys: String, CodingKey {
    case list = "Logs"
  }
  
// MARK: inits
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.list = try values.decode([Log].self, forKey: .list)
  }
  
  init() {
    self.list = []
  }

// MARK: methods
  func last(_ max: Int) -> [Log] {
    return self.list.suffix(max)
  }
  
  func last(for drug: Drug?, _ max: Int = 5) -> [Log] {
    return self.list.filter({ drug?.name == $0.name }).suffix(max)
  }
  
  mutating func add(log: Log) {
    self.list += [log]
  }
  
  mutating func add(logs: [Log]) {
    self.list += logs
  }

  @discardableResult mutating func popLast() -> Log? {
    return self.list.popLast()
  }
  
// MARK: operator overloads
  static func += (_ lhs: inout Self, _ rhs: Log) {
    lhs.add(log: rhs)
  }
  
  static func += (_ lhs: inout Self, _ rhs: [Log]) {
    lhs.add(logs: rhs)
  }
  
  static subscript(_ lhs: Self, _ key: Date) -> Log? {
    return lhs.list.first(where: { $0.date == key })
  }
  
  subscript(_ name: String) -> Log? {
    return self.list.last(where: { $0.name == name })
  }
}

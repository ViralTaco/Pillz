//
//  Model.swift
//  pillz
//
//  Created by viraltaco_ on 20191219.
//  Copyright © 2019-2020 viraltaco_. All rights reserved.
//

import CoreData

struct DrugList: Equatable & Codable & Writable {
  static let defaultPath = Defaults.drugsFile
  var drugs = Set<Drug>()

// MARK: coding keys
  enum CodingKeys: String, CodingKey {
    case drugs = "Drugs"
  }

// MARK: inits
  init(_ drugs: [Drug]) {
    self.drugs = Set(drugs)
  }

  init(_ drug: Drug) {
    self.drugs.insert(drug)
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.drugs = try values.decode(Set<Drug>.self, forKey: .drugs)
  }
  
  init() {}
  
// MARK: methods
  mutating func add(drugs: [Drug]) {
    self.drugs = self.drugs.union(drugs)
  }
  
  mutating func add(drug: Drug) {
    self.drugs.insert(drug)
  }
  
  mutating func add(doses: [Double], to name: String) throws {
    guard let id = self.drugs.firstIndex(where: { $0.isNamed(name) }) else {
      throw DrugError.noSuchDrug("\("Error".red): no drug named \(name)")
    }
    self.drugs[id].add(doses: doses)
  }
  
  mutating func add(dose: Double, to name: String) throws {
    try self.add(doses: [dose], to: name)
  }
  
  mutating func pop(at index: Int) -> Drug? {
    return self.drugs.pop(at: index)
  }
  
  @discardableResult mutating func drop(key: String) -> Self {
    self.drugs = self.drugs.filter { $0.name == key }
    return self
  }
  
  func all() -> [Drug] {
    return self.drugs.sorted(by: {
      (a, b) in a.name!.lexicographicallyPrecedes(b.name!)
    })
  }
  
// MARK: operator overloads
  static func += (_ lhs: inout Self, _ rhs: Drug) {
    lhs.add(drug: rhs)
  }
  
  static func += (_ lhs: inout Self, _ rhs: [Drug]) {
    lhs.add(drugs: rhs)
  }
  
  static subscript(_ lhs: Self, _ key: String) -> Drug? {
    return lhs.drugs.first(where: { $0.isNamed(key) })
  }
  
  subscript(_ index: Int) -> Drug? {
    return self.drugs[index]
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.drugs == rhs.drugs
  }
}

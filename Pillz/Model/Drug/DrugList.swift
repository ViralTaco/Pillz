//
//  Model.swift
//  pillz
//
//  Created by viraltaco_ on 20191219.
//  Copyright © 2019-2020 viraltaco_. All rights reserved.
//

import CoreData

class DrugList: Equatable & Codable & Writable {
  static let defaultPath = Defaults.drugsFile
  var drugs = Set<Drug>()
  lazy var count: Int = self.drugs.count

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

  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.drugs = try values.decode(Set<Drug>.self, forKey: .drugs)
  }
  
  required init() {}
  
// MARK: methods
  func add(drugs: [Drug]) {
    self.drugs = self.drugs.union(drugs)
  }
  
  func add(drug: Drug) {
    self.drugs.insert(drug)
  }
  
  func add(doses: [Double], to name: String) throws {
    guard let id = self.drugs.firstIndex(where: { $0.isNamed(name) }) else {
      throw DrugError.noSuchDrug("\("Error".red): no drug named \(name)")
    }
    self.drugs[id].add(doses: doses)
  }
  
  func add(dose: Double, to name: String) throws {
    try self.add(doses: [dose], to: name)
  }
  
  func pop(at index: Int) -> Drug? {
    return self.drugs.pop(at: index)
  }
  
  @discardableResult func drop(key: String) -> Self {
    self.drugs = self.drugs.filter { $0.name == key }
    return self
  }
  
  func all() -> [Drug] {
    return self.drugs.sorted(by: {
      (a, b) in a.name!.lexicographicallyPrecedes(b.name!)
    })
  }
  
// MARK: operator overloads
  static func += (_ lhs: inout DrugList, _ rhs: Drug) {
    lhs.add(drug: rhs)
  }
  
  static func += (_ lhs: inout DrugList, _ rhs: [Drug]) {
    lhs.add(drugs: rhs)
  }
  
  static subscript(_ lhs: Self, _ key: String) -> Drug? {
    return lhs.drugs.first(where: { $0.isNamed(key) })
  }
  
  subscript(_ index: Int) -> Drug? {
    guard index < self.count else { return nil }
    return self.drugs[index]
  }
  
  static func == (lhs: DrugList, rhs: DrugList) -> Bool {
    return lhs.drugs == rhs.drugs
  }
}

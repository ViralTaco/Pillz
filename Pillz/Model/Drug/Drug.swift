//
//  Drug.swift
//  pillz
//
//  Created by viraltaco_ on 20191219.
//  Copyright © 2019-2020 viraltaco_. All rights reserved.
//

enum DrugError: Error {
  case noSuchDrug(_ msg: String = "\("Error".red): no such drug.")
}

class Drug: Hashable & Codable & CustomStringConvertible {
  var name: String?
  var doses: Set<Double>
  
  var description: String { self.name! }
  var doseList: [Double] { self.doses.sorted(by: <) }
  var doseCount: Int { self.doses.count }
  

// MARK: coding keys
  enum CodingKeys: String, CodingKey {
    case name = "Name"
    case doses = "Doses"
  }
      
// MARK: inits
  init(name: String, dose: Double) {
    self.name = name.capitalized
    self.doses = [dose]
  }
  
  init(name: String, doses: [Double]) {
    self.name = name.capitalized
    self.doses = Set(doses)
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try values.decode(String.self, forKey: .name).capitalized
    self.doses = try values.decode(Set<Double>.self, forKey: .doses)
  }
  
  init() {
    self.name = nil
    self.doses = []
  }

// MARK: hasher
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.doses)
    hasher.combine(name)
  }

// MARK: methods
  func isNamed(_ name: String) -> Bool {
    guard self.name != nil else { return false }
    return self.name!.lowercased() == name.lowercased()
  }
  
  func add(dose: Double) {
    self.doses.insert(dose)
  }
  
  func add(doses: [Double]) {
    self.doses = self.doses.union(doses)
  }

  func pop(at dose: Int) -> Double? {
    return self.doses.pop(at: dose)
  }
  
// MARK: Operator overloads
  static func += (lhs: inout Drug, rhs: Double) {
    lhs.add(dose: rhs)
  }
  
  static func += (lhs: inout Drug, rhs: [Double]) {
    lhs.add(doses: rhs)
  }
  
  static func == (lhs: Drug, rhs: Drug) -> Bool {
    return lhs.doses == rhs.doses
        && lhs.name == rhs.name
  }

}

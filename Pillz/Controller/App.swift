//
//  App.swift
//  pillz
//
//  Created by viraltaco_ on 20200201.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

/**
 This is the main class. It will hold the different objects
 to let the view access them or ask for changes
 */

class App {
  public static let stop = false
  public var drugs: DrugList
  public var logs: LogList
  public var drugList: [Drug] { return self.drugs.all() }
  
  private let drugsReader: Reader<DrugList>
  private let logsReader: Reader<LogList>
  
// MARK: initis
  init() throws {
    self.drugsReader = try Reader()
    let drugs = try? drugsReader.read()
    self.drugs = drugs ?? DrugList()
    
    self.logsReader = try Reader()
    let logs = try? logsReader.read()
    self.logs = logs ?? LogList()
    
    // In case files aren't initialized yet
    try self.save() // BOHICA!
  }

// MARK: public methods
  public func reload() throws {
    self.drugs = try drugsReader.read()
    self.logs = try logsReader.read()
  }
  
  public func load(_ argType: Defaults.ArgumentType = .all) throws {
    switch argType {
    case .drugs:
      self.drugs = try drugsReader.read()
    case .logs:
      self.logs = try logsReader.read()
    case .all:
      try self.reload()
    }
  }
  
  public func save(_ argType: Defaults.ArgumentType) throws {
    switch argType {
    case .drugs:
      try Writer(from: self.drugs).write()
    case .logs:
      try Writer(from: self.logs).write()
    case .all:
      try self.save() // defined underneath
    }
  }
  
  public func save() throws {
    try self.save(.drugs)
    try self.save(.logs)
  }
  
  public func add(drug: Drug) {
    self.drugs += drug
  }
  
  public func add(dose: Double, to drug: String) throws {
    try self.drugs.add(dose: dose, to: drug)
  }
  
  public func addLog(for drug: Drug?, selection: Int) {
    let count = drug?.doseCount ?? -1
    guard selection < count  && selection >= 0 else { return }
    
    self.logs += Log(drug: drug, selection: selection)
  }
}

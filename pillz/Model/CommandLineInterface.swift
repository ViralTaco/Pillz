//
//  CommandLineInterface.swift
//  pillz
//
//  Created by viraltaco_ on 20200214.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation
import LineNoise
import Rainbow

class CommandLineInterface {
  private static let historyFilePath = "~/tmp/.pillz_cli_log"
  private let sin: LineNoise
  private let prompt: String
  
  required init(prompt: String = "> ".yellow) {
    self.sin = LineNoise()
    self.prompt = prompt
    
    self.sin.setHistoryMaxLength(100)
  }

// MARK: private methods
  private func save() throws -> Void {
    try self.sin.saveHistory(toFile: CommandLineInterface.historyFilePath)
    try self.sin.loadHistory(fromFile: CommandLineInterface.historyFilePath)
  }
  
// MARK: public methods
  public func read() -> String? {
    let result = try? self.sin.getLine(prompt: self.prompt)
    _ = try? self.save() // save history ignore Errors
    return result
  }
  
// MARK: setters
  public func
  setCompletion(_ completion: @escaping (String) -> ([String]) ) -> Void {
    self.sin.setCompletionCallback(completion)
  }
}

//
//  Command.swift
//  pillz
//
//  Created by viraltaco_ on 20200202.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

enum Command: String, CaseIterable {
  case back = "back"     // go back
  case help = "help"     // get help
  case clear = "clear"   // clear screen
  case cls = "cls"
  case last = "last"     // last n of selection
  case logs = "logs"     // last n lines of logs
  case add = "add"       // add something, this is a "private" case
  case addDrug = "drug"  // add a drug
  case addDose = "dose"  // add a dose to drug
  case rmlast = "rmlast" // remove last log
  case rmdrug = "rmdrug" // remove a drug
  case rmdose = "rmdose" // remove a dose
  
  case exit = "exit"
  case quit = "quit"
  
// MARK: public func
  public func completionStrings() -> [String] {
    var comps = ["add dose", "add drug"]
    
    for command in Self.allCases {
      comps.append(command.rawValue)
    }
    
    return comps
  }
}

enum CommandError: Error {
  case invalidAddCommand
  case invalidCommandChain(_ msg: String)
  case unexpectedArgument(_ msg: String)
  
  fileprivate static func message(invalid argument: String) -> String {
    return "\("Error".red): \"\(argument)\" isn't a valid command."
  }
  
  static func invalidChain(last: Command, current: Command) -> Self {
    .invalidCommandChain(message(invalid: "\(last) \(current)"))
  }
  
  static func unexpectedArgument(found invalid: String,
                                 after command: Command?) -> Self {
    .unexpectedArgument(
      message(invalid: "\(String(describing: command)) \(invalid)"))
  }
}

// MARK: App().command(String) throws -> Action?
extension App {
  public func command(_ command: String) throws -> Action? {
    // if string empty it's just enter key
    guard !command.isEmpty else { return Action.back }
    
    // the shortest command is 3 char long. Anything lower is a selection
    // MARK: command(Action.select(String))
    guard command.count > 2 else { return Action.select(command) }
    let commands = command.lowercased().split(separator: " ")
    
    var last: Command?
    var drugName: String?
    for cmd in commands {
      if let current = Command(rawValue: String(cmd)) {
        switch current {
        case .rmlast:
          if CustomView.confirm() { self.logs.popLast() }
          fallthrough
        case .back:
          return Action.back
        case .clear, .cls:
          return Action.clear
        case .help:
          return Action.help
        case .exit, .quit:
          return Action.exit
        default:
          last = current
          continue
        }
      }

      switch last {
      case .addDrug, .addDose:
        if drugName == nil { // not already set
          drugName = String(cmd) // now set. Next itter goes through elif:
        } else if let dose = Double(String(cmd)) {
          if last == .addDrug {
            self.add(drug: Drug(name: drugName!, dose: dose))
          } else {
            try self.add(dose: dose, to: drugName!)
          }
          drugName = nil
          last = nil
        } else {
          return Action.error(CommandError.invalidAddCommand)
        }
      case .last:
        if let selection = Int(String(cmd)) {
          return Action.last(selection)
        }
      case .logs:
        if let max = Int(String(cmd)) {
          return Action.logs(self.logs.last(max))
        }
      case .rmdrug, .rmdose:
        if let select = ID(String(cmd)) {
          return Action.rm(select)
        }
      default:
        continue
      } // switch last
    } // for command
    return Action.clear // default action
  }
} // extension App

//
//  CurrentView.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

enum CurrentView: Equatable {
  case main
  case help
  case last
  case logs
  case drug
  
  case error(_ value: String)

// MARK: Public methods
  mutating func back() {
    self = .main
  }

  func draw() {
    CurrentView.clear()
    switch self {
    case .help:
      print(CurrentView.boxed(ViewConstants.help))
      print(ViewConstants.footer)
    case .error(let msg):
      print(CurrentView.boxed(msg))
    case .drug, .main:
      banner()
    default:
      return
    }
  }
  
  func banner() {
    switch self {
    case .main:
      print(ViewConstants.banner())
    case .drug:
      print(ViewConstants.banner("dose"))
    default:
      return
    }
  }
  
// MARK: static funcs
  static func clear() {
    print(ViewConstants.clear)
  }
  
  static func separator() {
    print(ViewConstants.line)
  }
  
  static func orange(_ str: String) -> String {
    return ViewConstants.orange + str + ViewConstants.reset
  }

  static func boxed(_ str: String) -> String {
    return """
      \(ViewConstants.line)
      \(str)
      \(ViewConstants.line)
      """
  }
}

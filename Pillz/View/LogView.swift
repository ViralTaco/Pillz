//
//  LogView.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation
import Rainbow

struct LogView {
  static func doseString(_ dose: Double) -> String {
    guard dose < 1000.0 else {
      return "\(dose/1000.0)\(ViewConstants.gram) "
    }
    return "\(dose)\(ViewConstants.mg)"
  }
  
  static func extend(_ str: String, _ length: Int = 60) -> String {
    guard str.count < length else { return str }
    return str + " ".repeated(count: length - str.count)
  }
  
  static func print(_ log: Log?, lightBackground isAlt: Bool = false) -> Void {
    guard log != nil else { return }
    let lhs = DateView(for: log!.date!).fullDate
    let rhs = log!.name! <-> doseString(log!.dose!)
    let line = extend("  \(lhs)      \(rhs)")
    
    if isAlt {
      Swift.print(line.lightWhite.onBlack)
    } else {
      Swift.print(line)
    }
  }
  
  static func print(_ logs: [Log]) -> Void {
    CurrentView.separator()
    for i in 0..<logs.count {
      LogView.print(logs[i], lightBackground: i.isOdd)
    }
    CurrentView.separator()
  }
}

fileprivate extension Int {
  var isOdd: Bool { self & 0b1 != 0 }
}

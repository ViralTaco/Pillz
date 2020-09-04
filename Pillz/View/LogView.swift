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
  
  static func makeTableRow(date dv: DateView,
                           name n: String,
                           dose d: String,
                           pipe: ViewConstants.Glyth = .vertical) -> String {
    let p = pipe.rawValue
    let date = dv.dayDate
    let time = dv.time
    let name = n.leftJustified(width: ViewConstants.nameLength - 2)
    let dose = d.rightJustified(width: ViewConstants.doseLength - 2)
    let inner = [date, time, name, dose].joined(separator: " \(p) ")
    return "\(p) \(inner) \(p)"
  }
  
  static func print(_ log: Log?) -> Void {
    guard log != nil else { return }
    let line = makeTableRow(date: DateView(for: log!.date!),
                            name: log!.name!,
                            dose: doseString(log!.dose!))
    Swift.print(line.removingAllStyles())
  }
  
  static func print(_ logs: [Log]) -> Void {
    guard !logs.isEmpty else { return }
    let marks = [12, 7, ViewConstants.nameLength, ViewConstants.doseLength]
    let top = ViewConstants.makeTableHead(markAt: marks)
    let bottom = ViewConstants.makeTableHead(left: .bottomLeft,
                                             right: .bottomRight,
                                             separator: .bottomInner,
                                             markAt: marks)
    Swift.print(ViewConstants.clear + top)
    for i in 0..<logs.count {
      LogView.print(logs[i])
    }
    Swift.print(bottom)
  }
}

fileprivate extension Int {
  var isOdd: Bool { self & 1 != 0 }
}

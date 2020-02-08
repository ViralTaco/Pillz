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
  fileprivate static var dateFormatter: DateFormatter {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm"
    return df
  }
  
  static func dateToString(_ date: Date = Date()) -> String {
    return dateFormatter.string(from: date)
  }
  
  static func print(_ log: Log?) -> Void {
    guard log != nil else { return }
    let (date, name, dose) = (dateToString(log!.date!), log!.name!, log!.dose!)
    let mg = "mg".lightWhite
    Swift.print("  \(date)\t\(name)\t\(dose)\(mg)")
  }
  
  static func print(_ logs: [Log]) -> Void {
    CurrentView.separator()
    for log in logs {
      LogView.print(log)
    }
    CurrentView.separator()
  }
}

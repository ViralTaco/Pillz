//
//  DateView.swift
//  pillz
//
//  Created by viraltaco_ on 20200213.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

struct DateView: CustomStringConvertible {
  private let formatter = DateFormatter()
  let date: Date
  
  var year: String {
    self.formatter.dateFormat = "yyyy"
    return self.formatter.string(from: self.date)
  }
  var fullDate: String {
    self.formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return self.formatter.string(from: self.date)
  }
  var description: String { self.fullDate }
  
  init(for date: Date = Date()) {
    self.date = date
  }
}


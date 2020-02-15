//
//  Log.swift
//  pillz
//
//  Created by viraltaco_ on 20200103.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

protocol LogProtocol: Codable {
  var date: Date? { get }
  var name: String? { get }
  var dose: Double? { get }
}

struct Log: LogProtocol {
  let date: Date?
  let name: String?
  let dose: Double?
  
// MARK: coding keys
  enum CodingKeys: String, CodingKey {
    case date = "Date"
    case name = "Name"
    case dose = "Dose"
  }

// MARK: inits
  init(drug: Drug?, selection: Int) {
    self.date = Date()
    self.name = drug?.name
    self.dose = drug?.doseList[selection]
  }
  
  init(drug name: String, dose: Double) {
    self.date = Date()
    self.name = name
    self.dose = dose
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.date = try values.decode(Date.self, forKey: .date)
    self.name = try values.decode(String.self, forKey: .name)
    self.dose = try values.decode(Double.self, forKey: .dose)
  }
  
  init() {
    self.date = nil
    self.name = nil
    self.dose = nil
  }
}

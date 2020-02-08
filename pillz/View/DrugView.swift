//
//  DrugView.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation
import Rainbow

struct DrugView {
  static func list(_ drugs: [Drug]) {
    Swift.print()
    var index = ID()
    for drug in drugs {
      Swift.print("  [\("\(index)".bold)] \(drug.name!.capitalized)")
      index += 1
    }
    Swift.print() // new line
    CurrentView.separator()
  }
  
  static func list(_ drug: Drug) {
    CurrentView.separator()
    var index = ID()
    for dose in drug.doseList {
      Swift.print("  [\("\(index)".bold)] \(dose)\("mg".lightWhite)")
      index += 1
    }
    Swift.print()
  }
  
  static func print(_ drug: Drug?) {
    guard drug != nil else { return }
    CurrentView.separator()
    Swift.print("  " + drug!.name!.capitalized)
    DrugView.list(drug!)
  }
}

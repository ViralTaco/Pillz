//
//  Extensions.swift
//  pillz
//
//  Created by viraltaco_ on 20200206.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

extension Array where Element == Drug {
  func toDrugList() -> DrugList {
    return DrugList(self)
  }
}

extension Set {
  internal func at(_ index: Int) -> Index? {
    return self.index(self.startIndex,
                      offsetBy: index,
                      limitedBy: self.endIndex)
  }
  
  internal subscript(_ index: Int) -> Element? {
    guard let id = self.at(index) else {
      return nil
    }
    return self[id]
  }
  
  mutating func pop(at index: Int) -> Element? {
    guard let id = self.at(index) else {
      return nil
    }
    return self.remove(at: id)
  }
}

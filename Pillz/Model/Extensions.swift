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

extension Array {
  internal func at(_ index: Int) -> Element? {
    // 0 <= index < self.count
    guard 0..<self.count ~= index else { return nil }
    return self[index]
  }
}

extension Set {
  internal func at(_ index: Int) -> Index? {
    return self.index(self.startIndex,
                      offsetBy: index,
                      limitedBy: self.endIndex)
  }
  
  internal subscript(_ index: Int) -> Element? {
    guard let id = self.at(index) else { return nil }
    return self[id]
  }
  
  mutating func pop(at index: Int) -> Element? {
    guard let id = self.at(index) else { return nil }
    return self.remove(at: id)
  }
}

infix operator <->
extension String {
  internal func repeated(count: Int = 0) -> String {
    guard count > 0 else { return self }
    return Array(repeating: self, count: count)
      .reduce("", {(s, next) in s + next })
  }
  
  func rightJustified(width: Int, truncate: Bool = false) -> String {
      guard width > count else {
          return truncate ? String(suffix(width)) : self
      }
      return String(repeating: " ", count: width - count) + self
  }

  func leftJustified(width: Int, truncate: Bool = false) -> String {
      guard width > count else {
          return truncate ? String(prefix(width)) : self
      }
      return self + String(repeating: " ", count: width - count)
  }
  
  static func <-> (lhs: String, rhs: String) -> String {
    let spacing = abs(ViewConstants.spacing - (lhs.count + rhs.count))
    return lhs + " ".repeated(count: spacing) + rhs
  }
}

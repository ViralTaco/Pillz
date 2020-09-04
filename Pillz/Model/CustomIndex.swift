//
//  CustomIndex.swift
//  pillz
//
//  Created by viraltaco_ on 20200205.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

fileprivate extension String {
  /// For simplicity reason this func will return a concat of
  ///     both args in cases where nil would be more adequate.
  static func ... (lhs: String, rhs: String) -> String {
    let (left, right) = (UnicodeScalar(lhs), UnicodeScalar(rhs))
    
    if left != nil && right != nil {
      let range = UInt8(ascii: left!)...UInt8(ascii: right!)
      return range.reduce("", {
        $0 + String(Character(UnicodeScalar($1)))
      })
    } else if left == right && left != nil {
      return lhs // range from X to X is X
    } else {
      return lhs + "..." + rhs
    }
  }
}

class CustomIndex: CustomStringConvertible {
  private static let indices = Array(("a"..."z") + ("A"..."Z") + ("0"..."9"))
  private static let uniques = 61 // = Self.indices.count - 1 = 2 * 26 + 10 - 1
  
  var id: Int
  var description: String {
    var newID = self.id
    if newID > Self.uniques {
      var repeats = 1
      while newID > Self.uniques {
        repeats += 1
        newID /= 2
      }
      return String(Array(repeating: Self.indices[newID], count: repeats))
    } else {
      return String(Self.indices[id])
    }
  }
  
// MARK: init
  init(_ id: UInt = 0) {
    if id == 0 { self.id = 0 }
    else { self.id = Int(id - 1) }
  }
  
  init?(_ str: String) {
    guard let id = CustomIndex.indices.firstIndex(of: Character(str)) else {
      return nil
    }
    self.id = Int(id)
  }
  
// MARK: public methods
  static public func += (lhs: inout CustomIndex, rhs: UInt) {
    lhs.id += Int(rhs)
  }
}
// MARK: ID = CustomIndex
typealias ID = CustomIndex

// MARK: Int(_: ID) -> Int
public extension Int {
  internal init(_ index: ID) {
    self = index.id
  }
  
  internal init?(_ index: ID?) {
    guard index != nil else { return nil }
    self = index!.id
  }
}

// MARK: String(_: ID) -> String
public extension String {
  internal init(_ index: ID) {
    self = index.description
  }
}


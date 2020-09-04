//
//  Serializer.swift
//  pillz
//
//  Created by viraltaco_ on 20200131.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

protocol Writable {
  static var defaultPath: URL? { get }
  init() // needs to be able to init without args
}

// MARK: WritterError
enum WriterError: Error {
  case nilPath
  case invalidJSONEncoder
  case writeError(message: String)
  case invalidType(_ message: String)
  
  static func writeFailure(type: String, error: String) -> Self {
    .writeError(message: "\("Error".red): Writter<\(type)>.write failed.\n\(error)")
  }
}

// MARK: Writer<T>
class Writer<T: Writable & Codable> {
  public let encoded: Data
  
// MARK: init
  init(from raw: T) throws {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    
    do {
      self.encoded = try encoder.encode(raw)
    } catch {
      throw WriterError.invalidJSONEncoder
    }
  }
  
  convenience init(with codable: T.Type) throws {
    try self.init(from: T())
  }

// MARK: public funcs
  public func write(to path: URL? = T.defaultPath) throws {
    guard path != nil else { throw WriterError.nilPath }
    let str = String(data: self.encoded, encoding: .utf8)
    do {
      try str!.write(to: path!,
                     atomically: true,
                     encoding: String.Encoding.utf8)
    } catch let error as NSError {
      throw WriterError.writeFailure(type: "\(type(of: T.self))",
                                     error: "\(error)")
    }
  }
  
  public func write() throws {
    switch T.self {
    case is DrugList.Type:
      try self.write(to: Defaults.drugsFile)
    case is LogList.Type:
      try self.write(to: Defaults.logsFile)
    default:
      throw WriterError.invalidType("\("Error".red): no writer for \(type(of: T.self))")
    }
  }
}

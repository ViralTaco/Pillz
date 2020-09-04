//
//  Deserializer.swift
//  pillz
//
//  Created by viraltaco_ on 20200131.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

enum ReaderError: Error {
  case nilPath
  case invalidJSONDecoder
  case readError(message: String)
  
  static func readFailure(type: String,
                          error: String) -> Self {
    .readError(message:
      "\("Error".red): Reader<\(type)>.read() failed.\n\(error)")
  }
}

class Reader<T> where T: Writable & Decodable {
  private let path: URL
  
  init(from path: URL? = T.defaultPath) throws {
    guard path != nil else { throw ReaderError.nilPath }
    self.path = path!
  }
  
  public func read() throws -> T {
    let decoder = JSONDecoder()
    do {
      let data = try Data(contentsOf: self.path)
      return try decoder.decode(T.self, from: data)
      
    } catch let error as NSError {
      throw ReaderError.readFailure(type: "\(type(of: T.self))",
                                    error: "\(error)")
    }
  }
}

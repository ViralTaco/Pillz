//
//  Defaults.swift
//  pillz
//
//  Created by viraltaco_ on 20200201.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

public struct Defaults {
  public enum ArgumentType {
    case drugs
    case logs
    case all
  }
  
  static let fileManager = FileManager.default
  static let homeDir =
    fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
               .first // URL to ~/ or nil
  static let appDir = folder(name: "Pillz")
  static let logsFile = file(type: LogList.self, name: "logs")
  static let drugsFile = file(type: DrugList.self, name: "drugs")
  
  
// MARK: static funcs
  static func folder(path directory: URL? = homeDir,
                     name folderName: String) -> URL? {
    guard directory != nil else { return nil }
    
    let newDirURL = directory!.appendingPathComponent(folderName)
    if !fileManager.fileExists(atPath: newDirURL.path) {
      do {
        try fileManager.createDirectory(atPath: newDirURL.path,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
      } catch {
        print(error.localizedDescription)
        return nil
      }
    }
    
    return newDirURL
  }
  
  static func
  file<T: Writable & Codable>(type: T.Type,
                              path directory: URL? = appDir,
                              name fileName: String,
                              extension ext: String? = "json") -> URL? {
    guard directory != nil else { return nil }
    
    var fileURL = directory!.appendingPathComponent(fileName)
    if ext != nil { fileURL = fileURL.appendingPathExtension(ext!) }
    
    if !fileManager.fileExists(atPath: fileURL.path) {
      do {
        let writer = try Writer(with: type)
        fileManager.createFile(atPath: fileURL.path, contents: writer.encoded)
      } catch {
        return nil
      }
    }
    
    return fileURL
  }
}

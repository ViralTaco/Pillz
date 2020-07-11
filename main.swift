//
//  main.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//


import ArgumentParser
import Foundation


fileprivate func versionString() -> String {
  let version =
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
  
  return """
  pillz \(version as? String ?? "[VERSION UNDEFINED]")
  Copyright © 2019-\(DateView().year) viraltaco_
  """
}

fileprivate let licenseString = """
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in the
  Software without restriction, including without limitation the rights to use, copy,
  modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
  and to permit persons to whom the Software is furnished to do so,
  subject to the following conditions:
  
  The above copyright notice and this permission notice (including the next paragraph)
  shall be included in all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  
  """

fileprivate struct Pillz: ParsableCommand {
  @Flag(help: "Print version")
  var version = false

  @Flag(help: "Print license")
  var license = false
  
  @Flag(help: "Print version")
  var logs = false
  
  @Option(name: .shortAndLong,
          help: "Print last logs")
  var last: Int?

  mutating func run() throws {
    let view = ViewController()
    
    if version {
      print(versionString())
    } else if license {
      print(versionString(), licenseString)
    } else if logs {
      view.printLogs()
    } else if let count = last {
      view.last(count)
    } else {
      view.run()
    }
  }
}

Pillz.main()

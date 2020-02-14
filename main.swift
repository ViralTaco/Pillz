//
//  main.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

enum Argument: String {
  case last = "last"
  case logs = "logs"
  case version = "version"
  case help = "help"
}

let view = CustomView()
if let line = CommandLine.arguments.last?.filter({ $0.isLetter }) {
  let arg = Argument(rawValue: line)
  switch arg {
  case .last:
    view.last(5) // show the last 5
  case .logs:
    view.printLogs()
  case .version:
    view.printVersion()
  case .help:
    print(ViewConstants.usage)
  default:
    view.run()
  }
}

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
  case license = "license"
  case help = "help"
}

let view = CustomView()
let args = Array(CommandLine.arguments.dropFirst())
let arg0 = args.first ?? ""
let argument = Argument(rawValue: arg0.filter { $0.isLetter })

switch argument {
case .last:
  let count = Int(args[1]) ?? 5
  if count <= 0 { fallthrough }
  view.last(count)
case .help:
  print(ViewConstants.usage)
case .logs:
  view.printLogs()
case .version:
  view.printVersion()
case .license:
  view.printLicense()
default:
  view.run()
}



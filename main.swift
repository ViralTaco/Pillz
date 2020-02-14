//
//  main.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

let view = CustomView()

if let arg = CommandLine.arguments.last?.filter({ $0.isLetter }) {
  switch arg {
  case "last":
    view.last(5) // show the last 5
  case "version":
    view.printVersion()
  case "help":
    fallthrough
  default:
    print(ViewConstants.usage)
  }
} else {
  view.run()
}

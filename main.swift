//
//  main.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

let view = CustomView()

switch CommandLine.arguments.last?.filter({ $0.isLetter }) {
case "last":
  view.last(5) // show the last 5
case "help":
  print(ViewConstants.usage)
case "version":
  view.printVersion()
default:
  view.run()
}


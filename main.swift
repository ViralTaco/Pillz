//
//  main.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

let view = CustomView()

if CommandLine.arguments.last == "last" {
  view.last(5) // show the last 5
} else {
  view.run()
}


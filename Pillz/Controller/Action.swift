//
//  Actions.swift
//  pillz
//
//  Created by viraltaco_ on 20200203.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

import Foundation

enum Action {
  case back
  case clear
  case help
  case exit
  
  case logs(_ logs: [Log])
  case last(_ log: Int)
  case error(_ error: CommandError)
  case select(_ item: String)

  case rm(_ item: ID)
}

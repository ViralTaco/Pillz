//
//  Sin.swift
//  pillz
//
//  Created by viraltaco_ on 20200214.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

struct StandardInImplementation {
  let sin: CommandLineInterface
  
// MARK: inits
  init(prompt: String = "> ".yellow,
       completions: @escaping (String) -> ([String]) ) {
    self.sin = CommandLineInterface(prompt: prompt)
  }
 
// MARK: public methods
  func read() -> String? { return  self.sin.read() }
}

let sin = StandardInImplementation() { (buffer) in
  Command.completionStrings().filter { $0.hasPrefix(buffer) }
}

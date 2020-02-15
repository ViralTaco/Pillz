//
//  Sin.swift
//  pillz
//
//  Created by viraltaco_ on 20200214.
//  Copyright © 2020 viraltaco_. All rights reserved.
//
import LineNoise

struct StandardInImplementation {
  let prompt: String
  let sin: LineNoise
  
// MARK: inits
  init(prompt: String = "> ".yellow, completions: [String]) {
    self.prompt = prompt
    self.sin = LineNoise()
    
    self.sin.setCompletionCallback { buffer in
      completions.filter { $0.hasPrefix(buffer) }
    }
    
    self.sin.setHintsCallback { buffer in
      let filtered = completions.filter { $0.hasPrefix(buffer) }
      
      if let hint = filtered.first {
        return (String(hint.dropFirst(buffer.count)), (127, 0, 127))
      } else {
        return (nil, nil)
      }
    }
  }
 
// MARK: public methods
  func read() -> String? {
    return try? self.sin.getLine(prompt: self.prompt)
  }
}

struct Standard {
  public static let `in` =
    StandardInImplementation(completions: Command.completionStrings())
}

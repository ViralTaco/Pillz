//
//  ViewConstants.swift
//  pillz
//
//  Created by viraltaco_ on 20200206.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

struct ViewConstants {
  static let clear = "\u{001B}[2J"
  static let orange = "\u{001B}[1;38;5;208m"
  static let reset = "\u{001B}[0m"
  
// MARK: Menu text:
  static let help = """
    Help menu:
      
      Type \("exit".cyan) or \("quit".cyan) to exit the program
      Type \("back".cyan) to go back to the previous menu
      Type \("last".cyan) <\("Amount".lightBlue)> to show logs for a specific medication

      Type \("add drug".cyan) [\("name".lightBlue)] [\("dose".lightBlue)] to add a medication
      Type \("add dose".cyan) [\("drug".lightBlue)] [\("dose".lightBlue)] to add a dose to drug

      Type \("rmlast".cyan) to remove the last log entry
      Type \("rmdrug".cyan) <\("index".lightBlue)> to remove a drug
      Type \("rmdose".cyan) <\("index".lightBlue)> to remove a dose

      Type \("clear".cyan) or \("cls".cyan) to clear the screen
      Type \("help".cyan) to show this menu
      
    """
  static let confirm = """
    \("WARNING".red.bold): This action is irreversible!
    Are you sure you want to remove the last log entry?
    Type \("YES".yellow) to confirm, anything else to cancel.
    """
  static let footer = "\nPress the return key to go back to the main menu."

  static let drug = "drug"
  static let dose = "dose"

// MARK: Decoration:
  static let line = String(Array(repeating: "═", count: 60)).lightBlack
  
// MARK: Functions:
  static func banner(_ context: String = "drug") -> String {
    return """
      Please type the letter conresponding to the \(context) taken
      then press the return key. Type \("help".cyan) for help.
      
      """
  }
}

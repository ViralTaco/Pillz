//
//  ViewConstants.swift
//  pillz
//
//  Created by viraltaco_ on 20200206.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

struct ViewConstants {
  static let columns = 80 // number of chars in the view
  // half of view + half date string length - lhs spacing - rhs spacing.
  static let spacing = (columns / 2) + 12 - 2 - 6
  static let clear = "\u{001B}[2J" // \e[2J escape code (clear screen)

// MARK: license
  static let license = """
    
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
  
// MARK: usage
  static let usage = """
      Usage:
        pillz [option]
      
      options:
        last [N]              Print last N logs
        logs                  Print all the logs
        help, --help          Print this help screen
        version, --version    Print pillz version
        license, --license    Print pillz license
      """
  
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
  
  static let mg = "mg".italic
  static let gram = "g".italic
  
// MARK: Decoration:
  static let line = "═".lightBlack.repeated(count: Self.columns)
  
// MARK: Functions:
  static func banner(_ context: String = "drug") -> String {
    return """
      Please type the letter conresponding to the \(context) taken
      then press the return key. Type \("help".cyan) for help.
      
      """
  }
}

//
//  ViewConstants.swift
//  pillz
//
//  Created by viraltaco_ on 20200206.
//  Copyright © 2020 viraltaco_. All rights reserved.
//

struct ViewConstants {
  static let columns = 80
  static let rows = 24
  // half of view + half date string length - lhs spacing - rhs spacing.
  static let spacing = (columns / 2) + 12 - 2 - 6
  static let clear = "\u{001B}H\u{001B}[2J" // \e[H\e[2J (clear screen)
  
  static let nameLength = 42
  static let doseLength = 14

// MARK: Menu text:
  static let help = """
    Help menu:
      
      \("exit".cyan) or \("quit".cyan) to exit the program
      \("back".cyan) to go back to the previous menu
      \("last".cyan) <\("Amount".lightBlue)> to show logs for a specific medication

      \("add drug".cyan) [\("name".lightBlue)] [\("dose".lightBlue)] to add a medication
      \("add dose".cyan) [\("drug".lightBlue)] [\("dose".lightBlue)] to add a dose to drug

      \("rmlast".cyan) to remove the last log entry
      \("rmdrug".cyan) <\("index".lightBlue)> to remove a drug
      \("rmdose".cyan) <\("index".lightBlue)> to remove a dose

      \("clear".cyan) or \("cls".cyan) to clear the screen
      \("help".cyan) to show this menu
      
    """
  static let confirm = """
    \("\n")
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
  enum Glyth: String {
    case horizontal  = "━"
    case vertical    = "┃"
  
    case topLeft     = "┏"
    case topRight    = "┓"
    case topInner    = "┳"
  
    case bottomLeft  = "┗"
    case bottomRight = "┛"
    case bottomInner = "┻"
  }
  
  static let lineInner = Glyth.horizontal
                            .rawValue
                            .repeated(count: Self.columns - 2)
  static let line = Glyth.horizontal
                        .rawValue
                        .repeated(count: Self.columns)
                        .lightBlack
  static let lineTop =
    "\(Glyth.topLeft.rawValue)\(Self.lineInner)\(Glyth.topRight.rawValue)"
    .lightBlack
  static let lineBottom =
    "\(Glyth.bottomLeft.rawValue)\(Self.lineInner)\(Glyth.bottomRight.rawValue)"
    .lightBlack
  static let pipe = Glyth.vertical
                      .rawValue
                      .lightBlack
  
// MARK: Functions:
  static func banner(_ context: String = "drug") -> String {
    return """
      Please type the letter conresponding to the \(context) taken
      then press the return key. Type \("help".cyan) for help.
      
      """
  }
  
  static func makeLine(_ length: Int = Self.columns,
                       separator: Glyth = .horizontal) -> String {
    separator.rawValue.repeated(count: length)
  }

  static func makeTableHead(length: Int = columns,
                            left: Glyth = .topLeft,
                            right: Glyth = .topRight,
                            separator: Glyth = .topInner,
                            markAt distance: [Int]) -> String {
    var s = left.rawValue
    var d = distance
    if let last = d.popLast() {
      for i in d {
        s.append(makeLine(i))
        s.append(separator.rawValue)
      }
      s.append(makeLine(last))
    } else {
      s.append(makeLine(length - 2))
    }
    return s + right.rawValue
  }
}

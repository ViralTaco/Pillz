//
//   CustomView.swift
//   pillz
//
//   Created by viraltaco_ on 20200102.
//   Copyright © 2020 viraltaco_. All rights reserved.
//


/**
 * • The view begins with creating a DrugList and LogList
 *    using the DrugListDecoder and LogListDecoder
 *
 * • The view will show and edit the DrugList and LogList
 *
 * • The view ends with writing the changes to file
 *    using the DrugListEncoder and LogListEncoder
 */

import Foundation

class CustomView {
  let app: App
  var current: CurrentView = .main
  var drug: Drug? = nil
  
// MARK: init
  required init() {
    self.app = try! App()
    _ = doAction(Action.back) // MARK:  show main at start
    self.run()
  }

// MARK: public static methods
  public static func confirm() -> Bool {
    print(ViewConstants.confirm)
    if let answer = readLine() {
      if answer == "YES" { return true }
    }
    return false
  }
  
// MARK: private methods
  private func run() -> Never {
    while let line = CustomView.prompt() {
      if let action = try? app.command(line) {
        if doAction(action) == App.stop { break }
        save() // MARK:  before running another action, just save.
      }
    }
    return exit(EXIT_SUCCESS)
  }
  
  func doAction(_ action: Action) -> Bool {
    switch action {
    case .clear, .back:
      drawMain()
    case .last(let selection):
      self.last(selection)
    case .logs(let logs):
      self.current = .logs
      LogView.print(logs)
    case .help:
      setCurrent(.help)
    case .select(let selection):
      select(selection)
    case .error(let error):
      setCurrent(.error(error.localizedDescription))
    case .rm(let select):
      remove(select)
      
    case .exit:
      save()
      return App.stop
    }
    
    return true
  }
  
  private func remove(_ item: ID) -> Void {
    if self.current == .main {
      _ = self.app.drugs.pop(at: Int(item))
    } else if self.current == .drug { // MARK:  dose selection
      _ = self.drug?.pop(at: Int(item))
    }
  }
  
  private func save() -> Void {
    try? self.app.save()
  }
  
  private func last(_ max: Int) -> Void {
    if self.drug != nil {
      LogView.print(self.app.logs.last(for: self.drug, max))
    } else {
      LogView.print(self.app.logs.last(max))
    }
    drawMain()
  }
  
  private func setCurrent(_ new: CurrentView = .main) -> Void {
    self.current = new
    self.current.draw()
  }
  
  private func drawMain() -> Void {
    self.setCurrent()
    LogView.print(self.app.logs.last(5))
    DrugView.list(self.app.drugList)
  }
  
  private func select(_ selection: String) -> Void {
    CurrentView.clear()
    if let index = ID(selection) {
      if self.current != CurrentView.drug {
        setCurrent(.drug)
        self.drug = app.drugList[Int(index)]
        LogView.print(app.logs.last(for: self.drug))
        DrugView.print(self.drug)
      } else {
        app.addLog(for: self.drug, selection: Int(index))
        self.drug = nil
        drawMain()
      }
    }
  }
  
  private static func prompt() -> String? {
    print("\n" + CurrentView.orange(">"), terminator: " ")
    return readLine()
  }
}

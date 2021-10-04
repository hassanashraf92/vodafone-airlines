//
//  UIStoryboard+Extension.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

fileprivate enum Storyboard: String {
  case main = "Main"
}

fileprivate extension UIStoryboard {
  
  static func loadFromMain(_ identifier: String) -> UIViewController {
    return load(from: .main, identifier: identifier)
  }
  
  static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
    let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return uiStoryboard.instantiateViewController(withIdentifier: identifier)
  }
  
}

// MARK: App View Controllers

extension UIStoryboard {
  static func loadAirlinesTableViewController() -> AirlinesTableViewController {
    return loadFromMain("AirlinesTableViewController") as! AirlinesTableViewController
  }
  
  static func loadAirlineDetailsViewController() -> AirlineDetailsViewController {
    return loadFromMain("AirlineDetailsViewController") as! AirlineDetailsViewController
  }
  
}

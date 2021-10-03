//
//  HomeViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showAirlinesTableViewController()
  }
  
  fileprivate func showAirlinesTableViewController() {
    
    guard isViewLoaded else { return }
    
    let airlinesViewController = UIStoryboard.loadAirlinesTableViewController()
    airlinesViewController.viewModel = AirlinesTableViewModel()
    
    let airlinesNavController = UINavigationController(rootViewController: airlinesViewController)
    
    //TODO:- instantiate view model here..
    
    self.insertChildController(airlinesNavController, into: self.view)
    
    
  }
  
  
}

//
//  BaseViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }
  
  fileprivate func setupNavigationBar() {
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.layer.masksToBounds = false
    self.navigationController?.navigationBar.layer.shadowColor = UIColor.grayShadow.cgColor
    self.navigationController?.navigationBar.layer.shadowOpacity = 1
    self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
    self.navigationController?.navigationBar.layer.shadowRadius = 6

    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.tintColor = UIColor.black // to change the all text color in navigation bar or navigation
    self.navigationController?.navigationBar.barTintColor = UIColor.white // change the navigation background color
  }
  
  func showAlertController(title: String? = "Error", message: String? = "Something went wrong", handler: ( () -> Void )? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { _ in
      handler?()
    }
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
}

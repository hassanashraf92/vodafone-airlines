//
//  AirlinesTableViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

class AirlinesTableViewController: UIViewController {
  
  @IBOutlet weak var searchTextField: UITextField! {
    didSet {
      searchTextField.placeholder = "Search by airline name"
      searchTextField.layer.borderWidth = 1
      searchTextField.layer.borderColor = UIColor.border.cgColor
      searchTextField.layer.cornerRadius = 6
    }
  }
  
  @IBOutlet weak var searchView: RoundShadowView! {
    didSet {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchViewTapped(_:)))
      searchView.addGestureRecognizer(tapGesture)
    }
  }
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
    didSet {
      activityIndicator.style = .large
      activityIndicator.color = .primary
    }
  }
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
  }
  @IBOutlet weak var addView: CircleShadowView! {
    didSet {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addViewTapped(_:)))
      addView.addGestureRecognizer(tapGesture)
    }
  }
  
  var viewModel: AirlinesTableViewModel? {
    didSet {
      fillUI()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    fillUI()
  }
  
  fileprivate func setupNavigationBar() {
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.layer.masksToBounds = false
    self.navigationController?.navigationBar.layer.shadowColor = UIColor.grayShadow.cgColor
    self.navigationController?.navigationBar.layer.shadowOpacity = 1
    self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
    self.navigationController?.navigationBar.layer.shadowRadius = 6
  }
  
  fileprivate func fillUI() {
    guard isViewLoaded,
          let viewModel = viewModel else { return }
    
    self.navigationItem.title = viewModel.screenTitle
    
    viewModel.state.bind(observer: { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .empty, .error:
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0.0
          }
        }
      case .loading:
        DispatchQueue.main.async {
          self.activityIndicator.startAnimating()
          self.activityIndicator.isHidden = false
          UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0.0
          }
        }
      case .populated:
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          UIView.animate(withDuration: 0.2) {
            self.tableView.reloadData()
            self.tableView.alpha = 1.0
          }
        }
      default: break
      }
    })
    
    viewModel.airlineCellViewModels.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    
    viewModel.fetchData()
    
  }
  
  @objc private func searchViewTapped(_ sender: UITapGestureRecognizer) {
    guard let query = searchTextField.text else { return }
    viewModel?.searchAirline(query: query)
  }
  
  @objc private func addViewTapped(_ sender: UITapGestureRecognizer) {
    viewModel?.addNewAirline()
  }
  
  
}

extension AirlinesTableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.airlineCellViewModels.value?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) as? UITableViewCell
    cell?.textLabel?.text = viewModel?.getAirline(at: indexPath)?.name
    return cell!
  }
  
  
}

//
//  AirlinesTableViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

class AirlinesTableViewController: BaseViewController {
  
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
      let nib = UINib(nibName: "AirlineTableViewCell", bundle: nil)
      tableView.register(nib, forCellReuseIdentifier: "AirlineTableViewCell")
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
    fillUI()
  }
  
  fileprivate func fillUI() {
    guard isViewLoaded,
          let viewModel = viewModel else { return }
    
    self.navigationItem.title = viewModel.screenTitle
    
    viewModel.state.bind(observer: { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .error:
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0.0
          }
          self.showAlertController(title: "Something went wrong", message: viewModel.errorMessage)
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
    
    viewModel.airlineViewModels.bind { [weak self] _ in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    
    viewModel.fetchAirlinesData()
    
    //Observing new airline addition in order to reload data from API
    viewModel.observeNewAirlineAdd()
  }
  
  @objc private func searchViewTapped(_ sender: UITapGestureRecognizer) {
    guard let query = searchTextField.text else { return }
    viewModel?.searchAirline(query: query)
  }
  
  @objc private func addViewTapped(_ sender: UITapGestureRecognizer) {
    let addViewController = UIStoryboard.loadAddAirlineViewController()
    let viewModel = AddAirlineViewModel()
    addViewController.viewModel = viewModel
    self.present(addViewController, animated: true, completion: nil)
  }
}

extension AirlinesTableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.airlineViewModels.value?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "AirlineTableViewCell", for: indexPath) as? AirlineTableViewCell,
          let airline = viewModel?.getAirline(at: indexPath) else { return UITableViewCell() }
    cell.configure(airline)
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let index = viewModel?.selectedIndex else { return }
    guard let airline = viewModel?.getAirline(at: index) else { return }
    let airlineDetailsViewController = UIStoryboard.loadAirlineDetailsViewController()
    airlineDetailsViewController.viewModel = AirlineDetailsViewModel(airline)
    self.navigationController?.pushViewController(airlineDetailsViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    viewModel?.selectedIndex = indexPath
    return indexPath
  }
  
}

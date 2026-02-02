//
//  HomeViewController.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/28.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: StackOverflowItemsViewModel<SearchResultsRepository>!
    var coordinator: HomeCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setTitleImage()
        tableView.register(UINib(nibName: "StackOverflowTableViewCell", bundle: nil), forCellReuseIdentifier: "StackOverflowTableViewCell")
        toggleTableViewBackground()
    }
    
    private func setTitleImage() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    private func toggleTableViewBackground() {
        if viewModel.numberOfItems() > 0 {
            tableView.backgroundView = nil
        } else {
            let label = UILabel()
            label.text = "No data to display"
            label.textAlignment = .center
            label.textColor = .gray
            
            tableView.backgroundView = label
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomAlertSegue" {
            let controller = segue.destination as! CustomAlertViewController
            controller.alertTitle = "Error"
            controller.alertMessage = viewModel.errorMessage
        }
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, StackOverflowItemsViewModelDelegate {
    func dataHasChanged() {
        toggleTableViewBackground()
        tableView.reloadData()
    }
    
    func didReceiveError() {
        performSegue(withIdentifier: "CustomAlertSegue", sender: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let searchValue = searchBar.text {
            viewModel.getItems(with: searchValue)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StackOverflowTableViewCell", for: indexPath) as! StackOverflowTableViewCell
        cell.configure(with: viewModel.item(at: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetails(for: viewModel.item(at: indexPath.row))
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

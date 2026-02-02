//
//  StackOverflowItemDetailsViewController.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/28.
//

import UIKit
import WebKit

class StackOverflowItemDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: StackOverflowItemsViewModel<AnswersRepository>!
    var webViewHeights: [IndexPath: CGFloat] = [:]
    var question: StackOverflowQuestion!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "More Info"
        viewModel.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "SelectedItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectedItemTableViewCell")
        tableView.register(UINib(nibName: "AnswersTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswersTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getItems(with: String(question.question_id))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomAlertSegue" {
            let controller = segue.destination as! CustomAlertViewController
            controller.alertTitle = "Error"
            controller.alertMessage = viewModel.errorMessage
        }
    }

}

extension StackOverflowItemDetailsViewController: UITableViewDataSource, UITableViewDelegate, AdjustableHeight, StackOverflowItemsViewModelDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedItemTableViewCell", for: indexPath) as! SelectedItemTableViewCell
            cell.delegate = self
            cell.configure(with: question, index: indexPath.row)
            
            return cell
        } else {
            let answer = viewModel.item(at: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersTableViewCell", for: indexPath) as! AnswersTableViewCell
            cell.delegate = self
            cell.configure(with: answer, index: indexPath.row)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = webViewHeights[IndexPath(row: indexPath.row, section: 0)] {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func onHeightUpdated(height: CGFloat, index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        webViewHeights[indexPath] = height
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func dataHasChanged() {
        tableView.reloadData()
    }
    
    func didReceiveError() {
        performSegue(withIdentifier: "CustomAlertSegue", sender: nil)
    }
}

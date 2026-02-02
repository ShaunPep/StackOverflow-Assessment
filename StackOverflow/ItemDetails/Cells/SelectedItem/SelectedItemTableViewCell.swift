//
//  SelectedItemTableViewCell.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

import UIKit
import WebKit

//protocol SelectedItemTableViewCellDelegate: AnyObject {
//    func onHeightUpdated(height: CGFloat, index: Int)
//}

class SelectedItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var askedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    
    private var cellIndex: Int!
    weak var delegate: AdjustableHeight!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.navigationDelegate = self
        webview.scrollView.isScrollEnabled = false
        webview.scrollView.contentInset = .zero
        webview.scrollView.scrollIndicatorInsets = .zero
        webview.scrollView.contentInsetAdjustmentBehavior = .never
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        webview.loadHTMLString("", baseURL: nil)
    }
    
    private func renderProfileImage(imageUrl: String) {
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
    
    func configure(with selectedItem: StackOverflowQuestion, index: Int) {
        cellIndex = index
        
        titleLabel.text = selectedItem.title
        webview.loadHTMLString(selectedItem.body.wrappedInHTML(), baseURL: nil)
        askedLabel.text = "Asked \(selectedItem.creation_date.toDate(with: "MMM d"))"
        userNameLabel.text = selectedItem.owner.display_name
        reputationLabel.text = String(selectedItem.owner.reputation)
        answersLabel.text = "\(selectedItem.answer_count) Answers"
        
        renderProfileImage(imageUrl: selectedItem.owner.profile_image)
    }
    
}

extension SelectedItemTableViewCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.getBoundingClientRect().height") { [weak self] (height, error) in
            if let height = height as? CGFloat {
                self?.delegate.onHeightUpdated(height: height, index: self!.cellIndex)
            }
        }
    }
}

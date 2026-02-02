//
//  AnswersTableViewCell.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/31.
//

import UIKit
import WebKit

class AnswersTableViewCell: UITableViewCell {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var askedLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var acceptedImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    private var cellIndex: Int!
    weak var delegate: AdjustableHeight!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        webView.scrollView.contentInsetAdjustmentBehavior = .never
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func configure(with answer: StackOverflowAnswer, index: Int) {
        cellIndex = index
        
        votesLabel.text = String(answer.score)
        userNameLabel.text = answer.owner.display_name
        reputationLabel.text = String(answer.owner.reputation)
        acceptedImageView.isHidden = !answer.is_accepted
        webView.loadHTMLString(answer.body.wrappedInHTML(), baseURL: nil)
        
        renderProfileImage(imageUrl: answer.owner.profile_image)
    }
    
}

extension AnswersTableViewCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.getBoundingClientRect().height") { [weak self] (height, error) in
            if let height = height as? CGFloat {
                self?.webViewHeight.constant = height
                self?.delegate.onHeightUpdated(height: height, index: (self?.cellIndex)!)
            }
        }
    }
}

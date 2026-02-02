//
//  CustomAlertViewController.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/02/01.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    var alertTitle: String?
    var alertMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurBackground()
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
    }
    
    private func addBlurBackground() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.insertSubview(blurView, at: 0)
    }
    
    @IBAction func buttonTapped() {
        dismiss(animated: true)
    }

}

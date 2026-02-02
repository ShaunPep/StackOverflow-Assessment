//
//  StackOverflowTableViewCell.swift
//  StackOverflow
//
//  Created by Shaun Peplar on 2026/01/28.
//

import UIKit

class StackOverflowTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postedInformationLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: StackOverflowQuestion) {
        titleLabel.text = "Q: \(item.title)"
        answersLabel.text = "\(item.answer_count) answers"
        votesLabel.text = "\(item.score) votes"
        viewsLabel.text = "\(item.view_count) views"
        descriptionLabel.text = item.body.stripHTML()
        postedInformationLabel.text = "asked \(item.creation_date.toDate(with: "MMM d")) by \(item.owner.display_name)"
        
        checkImageView.isHidden = !item.is_answered
    }
    
}

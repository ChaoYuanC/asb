//
//  TransactionTableViewCell.swift
//  ASBInterviewExercise
//
//  Created by Charles on 31/07/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
    
}

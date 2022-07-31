//
//  TransactionDetailsViewController.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import UIKit

class TransactionDetailsViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!

    var transaction: Transaction?
    private let formatter = DateFormatter.transactionDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction Details"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissTransactionDetails))
        showDetails()
    }
    
    @objc func dismissTransactionDetails() {
        dismiss(animated: true, completion: nil)
    }

    private func showDetails() {
        guard let transaction = transaction else {
            return
        }
        stackView.addArrangedSubview(createLabel(text: "summary: \(transaction.summary)", color: .asbColor(.black)))
        stackView.addArrangedSubview(createLabel(text: "Date: \(formatter.string(from: transaction.transactionDate))", color: .asbColor(.black)))
        if let credit = transaction.creditString {
            stackView.addArrangedSubview(createLabel(text: "Credit: \(credit)", color: .asbColor(.green)))
        }
        if let debit = transaction.debitString {
            stackView.addArrangedSubview(createLabel(text: "Debit: \(debit)", color: .asbColor(.red)))
        }
        if let gst = transaction.gstString {
            stackView.addArrangedSubview(createLabel(text: "GST: \(gst)", color: .asbColor(.black)))
        }
        
    }
                                     
    private func createLabel(text: String, color: UIColor?) -> UILabel {
        let label = UILabel()
        let textColor = color != nil ? color! : .black
        let attributes = [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        label.attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        return label
    }
}

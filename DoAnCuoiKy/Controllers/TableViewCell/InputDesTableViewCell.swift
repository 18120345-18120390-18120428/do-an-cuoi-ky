//
//  InputDesTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol InputDesTableViewCellDelegate: class {
    func getDescription(text: String)
}
class InputDesTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var tvDescription: UITextView!
    weak var delegate: InputDesTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tvDescription.allowsEditingTextAttributes = true
        tvDescription.delegate = self
    }
    func textViewDidChange(_ textView: UITextView) {
        delegate?.getDescription(text: tvDescription.text)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        delegate?.getDescription(text: tvDescription.text)
    }
}

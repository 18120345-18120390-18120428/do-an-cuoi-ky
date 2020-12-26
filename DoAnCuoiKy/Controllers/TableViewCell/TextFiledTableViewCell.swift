//
//  TextFiledTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol TextFiledTableViewCellDelegate : class {
    func getName(text: String)
    func getAuthor(text: String)
}
class TextFiledTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAuthor: UITextField!
    weak var delegate: TextFiledTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfName.delegate = self
        tfAuthor.delegate = self
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.getName(text: tfName.text!)
        delegate?.getAuthor(text: tfAuthor.text!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

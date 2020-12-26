//
//  ButtonTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func tapNext()
}
class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var btnNext: UIButton!
    @IBAction func actionNext() {
        delegate?.tapNext()
    }
    weak var delegate: ButtonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

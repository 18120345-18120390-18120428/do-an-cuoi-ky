//
//  ChoseAvatarTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
protocol ChoseAvatarTableViewCellDelegate: class {
    func choseImage()
}
class ChoseAvatarTableViewCell: UITableViewCell {
    @IBOutlet weak var mainAvatar: UIImageView!
    @IBOutlet weak var coverAvatar: UIImageView!
    @IBOutlet weak var btnChoseImage: UIButton!
    weak var delegate: ChoseAvatarTableViewCellDelegate?
    @IBAction func actionCHoseImage() {
        delegate?.choseImage()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        mainAvatar.contentMode = .scaleToFill
        mainAvatar.layer.cornerRadius = 0.5 * mainAvatar.bounds.size.width
        coverAvatar.contentMode = .scaleToFill
        btnChoseImage.layer.cornerRadius = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

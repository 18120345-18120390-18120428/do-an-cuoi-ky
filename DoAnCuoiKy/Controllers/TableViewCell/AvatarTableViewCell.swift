//
//  AvatarTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/25/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {
    @IBOutlet weak var mainAvatar: UIImageView!
    @IBOutlet weak var coverAvatar: UIImageView!
    static let identifier = "AvatarTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AvatarTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        mainAvatar.layer.cornerRadius = 0.5 * mainAvatar.bounds.size.width
        mainAvatar.contentMode = .scaleToFill
        coverAvatar.image = UIImage(named: "background01")
        coverAvatar.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

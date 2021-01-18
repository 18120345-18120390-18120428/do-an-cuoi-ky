//
//  CommentTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 1/18/21.
//  Copyright © 2021 AnhKiem. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbStampTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 0.5 * avatar.bounds.size.width
        avatar.contentMode = .scaleToFill
        commentView.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

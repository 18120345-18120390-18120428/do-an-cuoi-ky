//
//  ListPostTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class ListPostTableViewCell: UITableViewCell {
    // Các biến quản lý đối tượng
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet var lbTittle: UILabel!
    @IBOutlet weak var subView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Giao diện Table View Cell
        subView.layer.cornerRadius = 15.0
        avatar.layer.cornerRadius = 0.5 * avatar.bounds.size.width
        avatar.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

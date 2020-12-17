//
//  PostTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    // Các biến quanr lý đối tượng
    @IBOutlet var outlet_chuong: UILabel!
    @IBOutlet var outlet_tenchuong: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

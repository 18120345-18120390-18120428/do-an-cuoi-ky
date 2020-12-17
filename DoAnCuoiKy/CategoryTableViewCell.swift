//
//  CategoryTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/11/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    // Các biến quản lý các đối tượng
    @IBOutlet weak var outlet_categorylabel: UILabel!
    @IBOutlet weak var outlet_categoryavatar: UIImageView!
    @IBOutlet weak var outlet_viewcell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

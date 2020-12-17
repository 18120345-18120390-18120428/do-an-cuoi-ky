//
//  VVTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class VVTableViewCell: UITableViewCell {
    // Các biến quản lý đối tượng
    @IBOutlet weak var logoItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Giao diện Table View Cell
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 50.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

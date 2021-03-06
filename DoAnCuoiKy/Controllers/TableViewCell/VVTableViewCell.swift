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
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbChapterNumber: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbUpdateDay: UILabel!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Giao diện Table View Cell
        myView.layer.cornerRadius = 10
        logoItem.layer.cornerRadius = logoItem.bounds.size.width * 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

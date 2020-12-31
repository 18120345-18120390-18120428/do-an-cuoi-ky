//
//  CategoryTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/11/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellDelegate: class {
    func tapCate1(text: String)
    func tapCate2(text: String)
}
class CategoryTableViewCell: UITableViewCell {
    // Các biến quản lý các đối tượng
    @IBOutlet weak var btnCategory1: UIButton!
    @IBOutlet weak var btnCategory2: UIButton!
    weak var delegate: CategoryTableViewCellDelegate?
    @IBAction func actGoCategory1() {
        delegate?.tapCate1(text: btnCategory1.titleLabel!.text!)
    }
    
    @IBAction func actGoCategory2() {
        delegate?.tapCate2(text: btnCategory2.titleLabel!.text!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

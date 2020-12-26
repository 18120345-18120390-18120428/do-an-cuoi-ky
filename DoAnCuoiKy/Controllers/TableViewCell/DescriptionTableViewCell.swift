//
//  DescriptionTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var lbDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lbDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbDescription.numberOfLines = 0
        lbDescription.sizeToFit()
        
        print("heigh: \(lbDescription.frame.height)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

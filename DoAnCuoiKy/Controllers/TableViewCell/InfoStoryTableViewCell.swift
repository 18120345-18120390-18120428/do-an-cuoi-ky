//
//  InfoStoryTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/25/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class InfoStoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbNumberOfChapters: UILabel!
    @IBOutlet weak var lbUpdateDay: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    static let identifier = "InfoStoryTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "InfoStoryTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

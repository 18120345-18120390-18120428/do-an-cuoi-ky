//
//  CustomTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/25/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
protocol CustomTableViewCellDelegate: class {
    func didTapReadStory()
}
class CustomTableViewCell: UITableViewCell {
    weak var delegate: CustomTableViewCellDelegate?
    @IBOutlet weak var btnReadStory: UIButton!
    @IBOutlet weak var lbRating: UILabel!
    @IBAction func actionReadStory() {
        delegate?.didTapReadStory()
    }
    @IBAction func actionLike(_ send: Any) {
        
    }
    @IBAction func actionComment(_ send: Any) {
        
    }
    @IBAction func actionShare(_ send: Any) {
        
    }
    @IBAction func actionDownload(_ send: Any) {
        
    }
    
    static let identifier = "CustomTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
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

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
    func didTapBarItem(item: UITabBarItem)
    func choseOneStar()
    func choseTwoStar()
    func choseThreeStar()
    func choseFourStar()
    func choseFiveStar()
}
class CustomTableViewCell: UITableViewCell, UITabBarDelegate {
    weak var delegate: CustomTableViewCellDelegate?
    @IBOutlet weak var btnReadStory: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var oneStar: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var fiveStar: UIButton!
    @IBAction func actionReadStory() {
        delegate?.didTapReadStory()
    }
    @IBAction func tapOneStar() {
        delegate?.choseOneStar()
    }
    @IBAction func tapTwoStar() {
        delegate?.choseTwoStar()
    }
    @IBAction func tapThreeStar() {
        delegate?.choseThreeStar()
    }
    @IBAction func tapFourStar() {
        delegate?.choseFourStar()
    }
    @IBAction func tapFiveStar() {
        delegate?.choseFiveStar()
    }
    @IBOutlet weak var itemLike: UITabBarItem!
    @IBOutlet weak var itemCommnet: UITabBarItem!
    @IBOutlet weak var itemShare: UITabBarItem!
    @IBOutlet weak var itemDownnload : UITabBarItem!
    
    static let identifier = "CustomTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tabBar.delegate = self
        
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        delegate?.didTapBarItem(item: item)
        tabBar.selectedItem = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

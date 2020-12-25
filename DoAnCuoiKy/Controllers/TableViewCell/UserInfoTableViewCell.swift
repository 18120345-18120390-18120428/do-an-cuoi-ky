//
//  UserInfoTableViewCell.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/25/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase


class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    static let identifier = "UserInfoTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "UserInfoTableViewCell", bundle: nil)
    }
    public func configure(with imageName: String) {
        myImageView.image = UIImage(named: imageName)
    }
    public func renameLb(with newName: String) {
        lbName.text = newName;
    }
    var ref: DatabaseReference!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myImageView.layer.cornerRadius = 0.5 * myImageView.bounds.size.width
        myImageView.contentMode = .scaleToFill
        lbName.textAlignment = .center
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            let urlImage = value?["photoURL"] as? String ?? ""
            if urlImage == ""{
                self.myImageView.image = #imageLiteral(resourceName: "avatar")
            }else{
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                self.myImageView.image = image
            }
                  
            let username = value?["username"] as? String ?? ""
            self.lbName.text! = username
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

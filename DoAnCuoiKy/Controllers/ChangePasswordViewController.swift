//
//  ChangePasswordViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_avatar: UIImageView!
    @IBOutlet weak var outlet_matkhaucu: UITextField!
    @IBOutlet weak var outlet_matkhaumoi: UITextField!
    @IBOutlet weak var outlet_nhaplai: UITextField!
    @IBOutlet weak var outlet_xacnhan: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Avatar
        outlet_avatar.layer.cornerRadius = 30.0
        
        // Giao diện khung mật khẩu hiện tại
        outlet_matkhaucu.layer.borderWidth = 1.0
        outlet_matkhaucu.layer.borderColor = UIColor.darkText.cgColor
        outlet_matkhaucu.layer.masksToBounds = true
        outlet_matkhaucu.layer.cornerRadius = 30.0
        
        // Giao diện khung mật khẩu mới
        outlet_matkhaumoi.layer.borderWidth = 1.0
        outlet_matkhaumoi.layer.borderColor = UIColor.darkText.cgColor
        outlet_matkhaumoi.layer.masksToBounds = true
        outlet_matkhaumoi.layer.cornerRadius = 30.0
        
        // Giao diện khung nhập lại mật khẩu
        outlet_nhaplai.layer.borderWidth = 1.0
        outlet_nhaplai.layer.borderColor = UIColor.darkText.cgColor
        outlet_nhaplai.layer.masksToBounds = true
        outlet_nhaplai.layer.cornerRadius = 30.0
        
        // Giao diện xác nhận
        outlet_xacnhan.layer.borderWidth = 1.0
        outlet_xacnhan.layer.borderColor = UIColor.white.cgColor
        outlet_xacnhan.layer.cornerRadius = 30.0
        
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Xác nhận
    @IBAction func action_xacnhan(_ sender: Any) {
    }
    
}

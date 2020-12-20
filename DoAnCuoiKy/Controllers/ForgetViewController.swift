//
//  ForgetViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/11/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class ForgetViewController: UIViewController {
    // Các biến quản lý giao diện
    @IBOutlet weak var outlet_email: UITextField!
    @IBOutlet weak var outlet_xacnhan: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện khung email
        outlet_email.layer.borderWidth = 1.0
        outlet_email.layer.borderColor = UIColor.darkText.cgColor
        outlet_email.layer.masksToBounds = true
        outlet_email.layer.cornerRadius = 30.0
        
        // Giao diện Xác nhận
        outlet_xacnhan.layer.borderWidth = 1.0
        outlet_xacnhan.layer.borderColor = UIColor.white.cgColor
        outlet_xacnhan.layer.masksToBounds = true
        outlet_xacnhan.layer.cornerRadius = 30.0
    }

    // Phần Xác nhận
    @IBAction func action_xacnhan(_ sender: Any) {
    }
}

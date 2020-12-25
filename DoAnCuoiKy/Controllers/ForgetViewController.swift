//
//  ForgetViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/11/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
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

    // Phần Xác nhận khi quên email
    @IBAction func action_xacnhan(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: outlet_email.text!) { error in
            if let error = error {
                Alertift.alert(title: "Error", message: error.localizedDescription)
                               .action(.default("OK"))
                               .show(on: self)
                return
            }else{
                Alertift.alert(title: "Notice", message: "A password reset email has been sent!")
                               .action(.default("OK"))
                               .show(on: self)
                return
            }
           
        }
    }
}

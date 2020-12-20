//
//  RegisViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class RegisViewController: UIViewController {
    // Các biến quản lý đối tượng
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfCheckPass: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var outlet_dangky: UIButton!
    @IBOutlet weak var outlet_avatar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Giao diện khung email
        tfEmail.layer.borderWidth = 1.0
        tfEmail.layer.borderColor = UIColor.darkText.cgColor
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.cornerRadius = 30.0
        
        // Giao diện khung pass
        tfPass.layer.borderWidth = 1.0
        tfPass.layer.borderColor = UIColor.darkText.cgColor
        tfPass.layer.masksToBounds = true
        tfPass.layer.cornerRadius = 30.0
        
        // Giao diện khung check pass
        tfCheckPass.layer.borderWidth = 1.0
        tfCheckPass.layer.borderColor = UIColor.darkText.cgColor
        tfCheckPass.layer.masksToBounds = true
        tfCheckPass.layer.cornerRadius = 30.0
        
        // Giao diện khung user name
        tfUsername.layer.borderWidth = 1.0
        tfUsername.layer.borderColor = UIColor.darkText.cgColor
        tfUsername.layer.masksToBounds = true
        tfUsername.layer.cornerRadius = 30.0
        
        // Giao diện đăng ký
        outlet_dangky.layer.borderWidth = 1.0
        outlet_dangky.layer.borderColor = UIColor.white.cgColor
        outlet_dangky.layer.masksToBounds = true
        outlet_dangky.layer.cornerRadius = 30.0
        
        // Giao diện khung chọn avatar
        outlet_avatar.layer.borderWidth = 1.0
        outlet_avatar.layer.borderColor = UIColor.white.cgColor
        outlet_avatar.layer.masksToBounds = true
        outlet_avatar.layer.cornerRadius = outlet_avatar.frame.size.width / 2
        
    }
    
    // Phần chọn Avatar
    @IBAction func action_avatar(_ sender: Any) {
        
    }
    
    // Phần Đăng ký
    @IBAction func btnDangKy(_ sender: Any) {
        if tfEmail.text!.isEmpty{
            Alertift.alert(title: "Error", message: "Please press email!")
            .action(.default("OK"))
            .show(on: self)
           
            return
        }
        if tfPass.text!.isEmpty{
           Alertift.alert(title: "Error", message: "Please press password!")
            .action(.default("OK"))
            .show(on: self)
            
            return
        }
        if tfCheckPass.text!.isEmpty{
            Alertift.alert(title: "Error", message: "Please press check password!")
            .action(.default("OK"))
            .show(on: self)
            
            return
        }
        if tfPass.text! == tfCheckPass.text! {
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPass.text!) { authResult, error in
                guard let user = authResult?.user, error == nil else{
                    print("Error : \(error!.localizedDescription)")
                    Alertift.alert(title: "Error", message: error?.localizedDescription)
                    .action(.default("OK"))
                    .show(on: self)
                    return
                }
                Alertift.alert(title: "Congratulations!", message: "You have successfully registered!")
                .action(.default("OK"))
                .show(on: self)
                let src = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                src.modalPresentationStyle = .fullScreen
                self.present(src, animated: true, completion: nil)
            }
        }
    }

}

//
//  LoginViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class LoginViewController: UIViewController {
    // Các biến quản lý đối tượng
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var outlet_dangnhap: UIButton!
    @IBOutlet weak var outlet_fb: UIButton!
    @IBOutlet weak var outlet_gg: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Giao diện khung tài khoản
        tfEmail.layer.borderWidth = 1.0
        tfEmail.layer.borderColor = UIColor.darkText.cgColor
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.cornerRadius = 30.0
        
        // Giao diện khung mật khẩu
        tfPassword.layer.borderWidth = 1.0
        tfPassword.layer.borderColor = UIColor.darkText.cgColor
        tfPassword.layer.masksToBounds = true
        tfPassword.layer.cornerRadius = 30.0
        
        // Giao diện khung đăng nhập
        outlet_dangnhap.layer.borderWidth = 1.0
        outlet_dangnhap.layer.borderColor = UIColor.white.cgColor
        outlet_dangnhap.layer.masksToBounds = true
        outlet_dangnhap.layer.cornerRadius = 30.0
        
        // Giao diện khung facebook
        outlet_fb.layer.borderWidth = 1.0
        outlet_fb.layer.borderColor = UIColor.white.cgColor
        outlet_fb.layer.masksToBounds = true
        outlet_fb.layer.cornerRadius = 30.0
        
        // Giao diện khung google
        outlet_gg.layer.borderWidth = 1.0
        outlet_gg.layer.borderColor = UIColor.white.cgColor
        outlet_gg.layer.masksToBounds = true
        outlet_gg.layer.cornerRadius = 30.0
    }
    
    // Hàm quản lý
    override func viewWillAppear(_ animated: Bool) {
        // kiem tra xem user da dang nhap chua, neu dang nhap roi chuyen sang man hinh trang chu
         Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Da dang nhap !")
                let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self.present(src!, animated: true, completion: nil)
            }
         }
    }
    
    // Phần Đăng nhập
    @IBAction func btnLogin(_ sender: Any) {
        //Kiem tra dang nhap hop le
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
                Alertift.alert(title: "Error", message: error.localizedDescription)
                .action(.default("OK"))
                .show(on: self)
                return
            }
            if Auth.auth().currentUser != nil {
                print(Auth.auth().currentUser?.uid)
                let src = self?.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self!.present(src!, animated: true, completion: nil)
                
            }
        }
       
    }

    // Phần quên mật khẩu
    @IBAction func action_quenmatkhau(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let forget = sb.instantiateViewController(withIdentifier: "ForgetViewController")
        self.navigationController?.pushViewController(forget, animated: true)
    }
    
    // Phần Đăng nhập bằng Facebook
    @IBAction func action_fb(_ sender: Any) {
    }
    
    // Phần Đăng nhập bằng Google
    @IBAction func action_gg(_ sender: Any) {
    }
}

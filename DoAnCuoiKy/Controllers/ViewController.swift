//
//  ViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/2/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_dangnhap: UIButton!
    @IBOutlet weak var outlet_dangky: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện nút đăng nhập
        outlet_dangnhap.layer.borderWidth = 1.0
        outlet_dangnhap.layer.borderColor = UIColor.white.cgColor
        outlet_dangnhap.layer.masksToBounds = true
        outlet_dangnhap.layer.cornerRadius = 30.0
        
        // Giao diện nút đăng ký
        outlet_dangky.layer.borderWidth = 1.0
        outlet_dangky.layer.borderColor = UIColor.systemPink.cgColor
        outlet_dangky.layer.masksToBounds = true
        outlet_dangky.layer.cornerRadius = 30.0
    }
    override func viewWillAppear(_ animated: Bool) {
        // kiem tra xem user da dang nhap chua, neu dang nhap roi chuyen sang man hinh trang chu
         Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("Da dang nhap !")
                let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self.present(src!, animated: true, completion: nil)
            }
         }
    }
   
    // Phần Đăng Nhập
    @IBAction func action_dangnhap(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let dangNhap = sb.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(dangNhap, animated: true)
    }
    
    // Phần Đăng ký
    @IBAction func action_dangky(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let dangKy = sb.instantiateViewController(withIdentifier: "RegisViewController")
        self.navigationController?.pushViewController(dangKy, animated: true)
    }
}


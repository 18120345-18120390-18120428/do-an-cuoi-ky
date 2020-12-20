//
//  InformationViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_avatar: UIImageView!
    @IBOutlet weak var outlet_tenuser: UILabel!
    @IBOutlet weak var outlet_mail: UILabel!
    @IBOutlet weak var outlet_gioitinh: UILabel!
    @IBOutlet weak var outlet_ngaysinh: UILabel!
    @IBOutlet weak var outlet_ngaythamgia: UILabel!
    @IBOutlet weak var outlet_chucdanh: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Avatar
        outlet_avatar.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung tài khoản
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

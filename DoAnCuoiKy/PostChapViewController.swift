//
//  PostChapViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class PostChapViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_thutuchuong: UITextField!
    @IBOutlet weak var outlet_tenchuong: UITextField!
    @IBOutlet weak var outlet_noidung: UITextField!
    @IBOutlet weak var outlet_luu: UIButton!
    @IBOutlet weak var outlet_trove: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện khung Thứ tự chương
        outlet_thutuchuong.layer.borderWidth = 1.0
        outlet_thutuchuong.layer.borderColor = UIColor.darkText.cgColor
        outlet_thutuchuong.layer.masksToBounds = true
        outlet_thutuchuong.layer.cornerRadius = 30.0
        
        // Giao diện khung Tên chương
        outlet_tenchuong.layer.borderWidth = 1.0
        outlet_tenchuong.layer.borderColor = UIColor.darkText.cgColor
        outlet_tenchuong.layer.masksToBounds = true
        outlet_tenchuong.layer.cornerRadius = 30.0
        
        // Giao diện khung Nội dung
        outlet_noidung.layer.borderWidth = 1.0
        outlet_noidung.layer.borderColor = UIColor.darkText.cgColor
        
        // Giao diện Lưu
        outlet_luu.layer.borderColor = UIColor.white.cgColor
        outlet_luu.layer.borderWidth = 1.0
        outlet_luu.layer.cornerRadius = 30.0
        
        // Giao diện Trở về
        outlet_trove.layer.borderColor = UIColor.systemPink.cgColor
        outlet_trove.layer.borderWidth = 1.0
        outlet_trove.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung chương (nếu chỉnh sửa)
        
    }

    // Phần Lưu
    @IBAction func action_luu(_ sender: Any) {
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

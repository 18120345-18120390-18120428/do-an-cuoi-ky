//
//  StoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_trove: UIButton!
    @IBOutlet weak var outlet_chuongtiep: UIButton!
    @IBOutlet weak var outlet_noidung: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Trở về
        outlet_trove.layer.borderWidth = 1.0
        outlet_trove.layer.borderColor = UIColor.white.cgColor
        outlet_trove.layer.cornerRadius = 30.0
        
        // Giao diện Chương tiếp
        outlet_chuongtiep.layer.borderWidth = 1.0
        outlet_chuongtiep.layer.borderColor = UIColor.systemPink.cgColor
        outlet_chuongtiep.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung truyện
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Chương tiếp
    @IBAction func action_chuongtiep(_ sender: Any) {
    }
    
}

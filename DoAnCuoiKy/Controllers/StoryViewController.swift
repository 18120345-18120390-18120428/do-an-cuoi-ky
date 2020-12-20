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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbChapterContent: UILabel!
    var content = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Trở về
        btnBack.layer.borderWidth = 1.0
        btnBack.layer.borderColor = UIColor.white.cgColor
        btnBack.layer.cornerRadius = 30.0
        
        // Giao diện Chương tiếp
        btnNext.layer.borderWidth = 1.0
        btnNext.layer.borderColor = UIColor.systemPink.cgColor
        btnNext.layer.cornerRadius = 30.0
        lbChapterContent.text = content
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

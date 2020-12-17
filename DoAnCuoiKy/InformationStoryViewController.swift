//
//  InformationStoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/15/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class InformationStoryViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_avatar: UIImageView!
    @IBOutlet weak var outlet_tentruyen: UILabel!
    @IBOutlet weak var outlet_tacgia: UILabel!
    @IBOutlet weak var outlet_theloai: UILabel!
    @IBOutlet weak var outlet_trangthai: UILabel!
    @IBOutlet weak var outlet_sochuong: UILabel!
    @IBOutlet weak var outlet_ngayviet: UILabel!
    @IBOutlet weak var outlet_ngaycapnhat: UILabel!
    @IBOutlet weak var outlet_diem: UILabel!
    @IBOutlet weak var outlet_doctruyen: UIButton!
    @IBOutlet weak var outlet_noidungtomtat: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Avatar
        outlet_avatar.layer.cornerRadius = 50.0
        
        // Hiển thị thông tin truyện
        
        // Giao diện Đọc truyện
        outlet_doctruyen.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung tóm tắt
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Đọc truyện
    @IBAction func action_doctruyen(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let docTruyen = sb.instantiateViewController(withIdentifier: "StoryViewController") as! StoryViewController
        docTruyen.modalPresentationStyle = .fullScreen
        self.present(docTruyen, animated: true, completion: nil)
    }
    
    // Phần Đánh giá
    @IBAction func action_star01(_ sender: Any) {
    }
    
    @IBAction func action_star02(_ sender: Any) {
    }
    
    @IBAction func action_star03(_ sender: Any) {
    }
    
    @IBAction func action_star04(_ sender: Any) {
    }
    
    @IBAction func action_star05(_ sender: Any) {
    }
    
    // Phần Yêu thích
    @IBAction func action_yeuthich(_ sender: Any) {
    }
    
    // Phần Chương
    @IBAction func action_chuong(_ sender: Any) {
    }
    
    // Phần Chia sẻ
    @IBAction func action_chiase(_ sender: Any) {
    }
    
    // Phần Tải về
    @IBAction func action_taive(_ sender: Any) {
    }
    
}

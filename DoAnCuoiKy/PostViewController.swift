//
//  PostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet var outlet_tentruyen: UITextField!
    @IBOutlet var outlet_tacgia: UITextField!
    @IBOutlet var outlet_theloai: UITextField!
    @IBOutlet var outlet_avatar: UIImageView!
    @IBOutlet var outlet_chonavatar: UIButton!
    @IBOutlet var outlet_tableview: UITableView!
    var pickerView = UIPickerView()
    @IBOutlet weak var outlet_luu: UIButton!
    @IBOutlet weak var outlet_trove: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khai báo Table View
        outlet_tableview.delegate = self
        outlet_tableview.dataSource = self
        
        // Khai báo Picker View
        pickerView.delegate = self
        pickerView.dataSource = self
        outlet_theloai.inputView = pickerView
        pickerView.layer.backgroundColor = UIColor.white.cgColor
        pickerView.layer.borderWidth = 3.0
        pickerView.layer.borderColor = UIColor.darkGray.cgColor
        
        // Giao diện khung tên truyện
        outlet_tentruyen.layer.borderWidth = 1.0
        outlet_tentruyen.layer.borderColor = UIColor.darkText.cgColor
        outlet_tentruyen.layer.masksToBounds = true
        outlet_tentruyen.layer.cornerRadius = 30.0
        
        // Giao diện khung tác giả
        outlet_tacgia.layer.borderWidth = 1.0
        outlet_tacgia.layer.borderColor = UIColor.darkText.cgColor
        outlet_tacgia.layer.masksToBounds = true
        outlet_tacgia.layer.cornerRadius = 30.0
        
        // Giao diện khung thể loại
        outlet_theloai.layer.borderWidth = 1.0
        outlet_theloai.layer.borderColor = UIColor.darkText.cgColor
        outlet_theloai.layer.masksToBounds = true
        outlet_theloai.layer.cornerRadius = 30.0
        
        // Giao diện Avatar
        outlet_avatar.layer.cornerRadius = 30.0
        
        // Giao diện nút chọn Avatar
        outlet_chonavatar.layer.cornerRadius = 30.0
        
        // Giao diện Lưu
        outlet_luu.layer.borderColor = UIColor.white.cgColor
        outlet_luu.layer.borderWidth = 1.0
        outlet_luu.layer.cornerRadius = 30.0
        
        // Giao diện Trở về
        outlet_trove.layer.borderColor = UIColor.systemPink.cgColor
        outlet_trove.layer.borderWidth = 1.0
        outlet_trove.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung phụ lục truyện
    }
    
    let category = ["Ngôn Tình", "Kiếm Hiệp", "Truyện Teen", "Truyện Ma", "Quân Sự", "Trinh Thám", "Lịch Sử", "Tiểu Thuyết", "Thiếu Nhi", "Truyện Ngắn", "Truyện Cười", "Cổ Tích", "Nước Ngoài", "Khoa Học"]

    // Phần Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        outlet_theloai.text = category[row]
        outlet_theloai.resignFirstResponder()
    }
    
    // Phần chọn Avatar
    @IBAction func action_chonavatar(_ sender: Any) {
    }
    
    // Phần Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 7
     }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell") as! PostTableViewCell
        
        // Nội dung Cell
        cell.outlet_chuong.text = "Chương 01"
        cell.outlet_tenchuong.text = "Em là ai?"
    
        
        // Giao diện Cell
        cell.outlet_chuong.layer.borderColor = UIColor.darkText.cgColor
        cell.outlet_chuong.layer.borderWidth = 1.0
        
        cell.outlet_tenchuong.layer.borderColor = UIColor.darkText.cgColor
        cell.outlet_tenchuong.layer.borderWidth = 1.0
     
         return cell
     }
    
    // Phần Thêm chương
    @IBAction func action_themchuong(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let themChuong = sb.instantiateViewController(withIdentifier: "PostChapViewController") as! PostChapViewController
        themChuong.modalPresentationStyle = .fullScreen
        self.present(themChuong, animated: false, completion: nil)
    }
    
    // Phần Lưu
    @IBAction func action_luu(_ sender: Any) {
    }
    
    // Phần trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


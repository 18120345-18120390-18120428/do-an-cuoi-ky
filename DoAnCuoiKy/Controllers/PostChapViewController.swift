//
//  PostChapViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol UpdatePostTable: class {
    func updateInfo(newChapter: Chapter)
}
class PostChapViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var chapterOrderField: UITextField!
    @IBOutlet weak var chapterNameField: UITextField!
    @IBOutlet weak var chapterContentField: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    weak var delegate: UpdatePostTable?
    
    var chapter: Chapter = Chapter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện khung Thứ tự chương
        chapterOrderField.layer.borderWidth = 1.0
        chapterOrderField.layer.borderColor = UIColor.darkText.cgColor
        chapterOrderField.layer.masksToBounds = true
        chapterOrderField.layer.cornerRadius = 30.0
        
        // Giao diện khung Tên chương
        chapterNameField.layer.borderWidth = 1.0
        chapterNameField.layer.borderColor = UIColor.darkText.cgColor
        chapterNameField.layer.masksToBounds = true
        chapterNameField.layer.cornerRadius = 30.0
        
        // Giao diện khung Nội dung
        chapterContentField.layer.borderWidth = 1.0
        chapterContentField.layer.borderColor = UIColor.darkText.cgColor
        
        // Giao diện Lưu
        btnSave.layer.borderColor = UIColor.white.cgColor
        btnSave.layer.borderWidth = 1.0
        btnSave.layer.cornerRadius = 30.0
        
        // Giao diện Trở về
        btnBack.layer.borderColor = UIColor.systemPink.cgColor
        btnBack.layer.borderWidth = 1.0
        btnBack.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung chương (nếu chỉnh sửa)
        
    }

    // Phần Lưu
    @IBAction func action_luu(_ sender: Any) {
        chapter.addNewChapter(chapterOrder: chapterOrderField.text!, chapterName: chapterNameField.text!, chapterContent: chapterContentField.text!)
        delegate?.updateInfo(newChapter: chapter)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

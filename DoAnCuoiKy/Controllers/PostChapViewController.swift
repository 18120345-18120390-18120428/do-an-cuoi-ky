//
//  PostChapViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol PostChapViewControllerDelegate: class {
    func updateInfo(newChapter: Chapter)
}
class PostChapViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var chapterOrderField: UITextField!
    @IBOutlet weak var chapterNameField: UITextField!
//    @IBOutlet weak var chapterContentField: UITextField!
    @IBOutlet weak var tvChapterContent: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    weak var delegate: PostChapViewControllerDelegate?
    
    var chapter: Chapter = Chapter()
    override func viewDidLoad() {
        super.viewDidLoad()
        tvChapterContent.allowsEditingTextAttributes = true
        chapterOrderField.text = chapter.chapterOrder
        chapterNameField.text = chapter.chapterName
        tvChapterContent.text = chapter.chapterContent
        
    }
        // Hiển thị nội dung chương (nếu chỉnh sửa)
        

//     Phần Lưu
    @IBAction func action_luu(_ sender: Any) {
        print("Save")
        chapter.addNewChapter(chapterOrder: chapterOrderField.text!, chapterName: chapterNameField.text!, chapterContent: tvChapterContent.text)
        delegate?.updateInfo(newChapter: chapter)
        self.navigationController?.popViewController(animated: true)
    }

}

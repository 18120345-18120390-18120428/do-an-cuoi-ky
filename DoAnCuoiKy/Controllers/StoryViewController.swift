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
    @IBOutlet weak var textViewContent: UITextView!
    var content: [Chapter] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewContent.text = content[0].chapterContent
        // Hiển thị nội dung truyện
        
    }
    
    // Phần Trở về
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Chương tiếp
    
}

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
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbStoryName: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbChapterNumer: UILabel!
    @IBOutlet weak var lbUpdateDay: UILabel!
    @IBOutlet weak var lbUpdateDay1: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var btnReadStory: UIButton!
    @IBOutlet weak var lbDescription: UILabel!
    
    var story = Story()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Giao diện Avatar
        avatar.layer.cornerRadius = 50.0
        
        // Hiển thị thông tin truyện
        
        // Giao diện Đọc truyện
        btnReadStory.layer.cornerRadius = 30.0
        
        // Hiển thị nội dung tóm tắt
        avatar.image = story.avatar
        lbStoryName.text = story.name
        lbAuthor.text = "Tác giả: " +  story.author
        lbCategory.text = "Thể loại: " + story.category
        if (story.status) {
            lbStatus.text = "Trạng thái: Hoàn thành"
        }
        else {
            lbStatus.text = "Trạng thái: Chưa hoàn thành"
        }
        lbChapterNumer.text = "Số chương: \(story.chapterNumber)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: story.timestamp)
        lbUpdateDay.text = "Ngày viết: " + date
        lbUpdateDay1.text = "Ngày cập nhật: " + date
        lbRating.text = "Điểm đánh giá: \(story.rating)/5"
        lbDescription.text = story.description
    }
    
    // Phần Trở về
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Đọc truyện
    @IBAction func actionReadStory(_ sender: Any) {
        performSegue(withIdentifier: "readStory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storyViewController = segue.destination as! StoryViewController
        storyViewController.content = story.storyContent[0].chapterContent
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

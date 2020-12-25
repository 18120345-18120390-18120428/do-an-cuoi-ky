//
//  InformationStoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/15/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class InformationStoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var story = Story()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(AvatarTableViewCell.nib(), forCellReuseIdentifier: AvatarTableViewCell.identifier)
//        tableView.register(InfoStoryTableViewCell.nib(), forCellReuseIdentifier: InfoStoryTableViewCell.identifier)
//        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Load Avatar
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarTableViewCell", for: indexPath) as! AvatarTableViewCell
            cell.mainAvatar.image = story.avatar
            return cell
        }
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoStoryTableViewCell", for: indexPath) as! InfoStoryTableViewCell
            cell.lbName.text = story.name
            cell.lbAuthor.text = "Tác giả: " +  story.author
            cell.lbCategory.text = "Thể loại: " + story.category
            cell.lbNumberOfChapters.text = "Số chương: \(story.numberOfChapters)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.string(from: story.timestamp)
            cell.lbUpdateDay.text = "Ngày viết: " + date
            if (story.status) {
                cell.lbStatus.text = "Trạng thái: Hoàn thành"
            }
            else {
                cell.lbStatus.text = "Trạng thái: Chưa hoàn thành"
            }
            cell.lbRating.text = "Điểm đánh giá: \(story.rating)/5"
            return cell
        }
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "HIHIIHIHIHIH"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 200
        }
        if (indexPath.row == 1) {
            return 200
        }
        if (indexPath.row == 2) {
            return 150
        }
        return 30
    }
    
}

extension InformationStoryViewController: CustomTableViewCellDelegate {
//    func didTapReadStory(text: String) {
//        print(text)
//    }
    func didTapReadStory() {
        print("hihihihih")
        performSegue(withIdentifier: "readStory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storyViewController = segue.destination as! StoryViewController
        storyViewController.content = story.storyContent
    }
}

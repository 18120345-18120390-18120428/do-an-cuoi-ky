//
//  InformationStoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/15/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class InformationStoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var liked = false
    var rating = 0
    var storyName = ""
    var likes = 0;
    var arrayStory : [Story] = []
    var favoriteBook : [String] = []
    var listRating : [String : Int?] = [:]
    private var story = Story()
    var ref = Database.database().reference()
    @IBOutlet weak var tableView: UITableView!
    var heightDescription: CGFloat = 100.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        fetchStory(name: storyName)
        fetchDataUser()
    }
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func fetchDataUser() {
        let userID = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
//            let liked = value?["photoURL"] as? String ?? ""
            if (snapshot.hasChild("favoriteBook")) {
                self.favoriteBook = value?["favoriteBook"] as! [String]
            }
            
            if (snapshot.hasChild("rating")) {
                self.listRating = value?["rating"] as! [String : Int?]
            }
            
            if (self.listRating[self.story.name] != nil) {
                self.rating = self.listRating[self.story.name]!!
            }
            if self.favoriteBook.contains(self.story.name) {
                self.liked = true
            }
            self.tableView.reloadData()
        })
    }
    func fetchStory(name: String) {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        ref.child("Stories").queryOrdered(byChild: "name").queryStarting(atValue: name).queryEnding(atValue: storyName+"\u{f8ff}").observe(.value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                let author = storyDict["author"] as! String
                let category = storyDict["category"] as! String
                let urlImage = storyDict["avatar"] as! String
                let description = storyDict["description"] as! String
                let updateDay = storyDict["timestamp"] as! String
                self.likes = storyDict["likes"] as! Int
                let newStory: Story = Story()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let date = dateFormatter.date(from:updateDay)!
                newStory.timestamp = date
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                newStory.addSimpleStory(name: name, author: author, category: category, avatar: image)
                newStory.description = description
                let storyContent = snap.childSnapshot(forPath: "storyContent")
                for chapter in storyContent.children {
                    let snap1 = chapter as! DataSnapshot
                    let chapterDict = snap1.value as! [String: Any]
                    let chapterOrder = chapterDict["chapterOrder"] as! String
                    let chapterName = chapterDict["chapterName"] as! String
                    let chapterContent = chapterDict["chapterContent"] as! String
                    let newChapter = Chapter()
                    newChapter.addNewChapter(chapterOrder: chapterOrder, chapterName: chapterName, chapterContent: chapterContent)
                    newStory.storyContent.append(newChapter)
                }
                newStory.numberOfChapters = newStory.storyContent.count
                print("new story: \(newStory.name)")
                self.arrayStory.append(newStory)
                self.story = self.arrayStory.first!
                print("Story: \(self.story)")
                self.tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        })
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
            if (liked) {
                cell.itemLike.image = UIImage(systemName: "heart.fill")
            } else {
                cell.itemLike.image = UIImage(systemName: "heart")
            }
            switch rating {
            case 1:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            case 2:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            case 3:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            case 4:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            case 5:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
            default:
                cell.oneStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.twoStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.threeStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fourStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
                cell.fiveStar.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
            }
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
        cell.lbDescription.text = story.description
        cell.lbDescription.sizeToFit()
        heightDescription = cell.lbDescription.frame.height + 50
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
        return CGFloat(heightDescription)
    }
}

extension InformationStoryViewController: CustomTableViewCellDelegate {
    func choseOneStar() {
        rating = 1;
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)/rating/")
        ref.updateChildValues([
            "\(story.name)" : rating
        ])
        tableView.reloadData()
    }
    
    func choseTwoStar() {
        rating = 2;
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)/rating/")
        ref.updateChildValues([
            "\(story.name)" : rating
        ])
        tableView.reloadData()
    }
    
    func choseThreeStar() {
        rating = 3;
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)/rating/")
        ref.updateChildValues([
            "\(story.name)" : rating
        ])
        tableView.reloadData()
    }
    
    func choseFourStar() {
        rating = 4;
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)/rating/")
        ref.updateChildValues([
            "\(story.name)" : rating
        ])
        tableView.reloadData()
    }
    
    func choseFiveStar() {
        rating = 5;
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)/rating/")
        ref.updateChildValues([
            "\(story.name)" : rating
        ])
        tableView.reloadData()
    }
    
    func didTapBarItem(item: UITabBarItem) {
        if (item.title == "Thích") {
            if (liked) {
                liked = false
                if let index = favoriteBook.firstIndex(of: story.name) {
                    favoriteBook.remove(at: index)
                }
                likes = likes - 1
            } else {
                liked = true
                favoriteBook.append(story.name)
                likes = likes + 1
            }
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)")
            ref.updateChildValues([
                "favoriteBook": self.favoriteBook
            ])
            let ref2 = Database.database().reference().child("Stories/\(story.name)")
            ref2.updateChildValues([
                "likes": likes,
                "rating": rating
            ])
            tableView.reloadData()
        }
    }
    
    func didTapReadStory() {
        performSegue(withIdentifier: "readStory", sender: self)
    }
    func showNote() {
        
        let alert = UIAlertController(title: "Chưa có chương", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction.init(title: "Huỷ", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let storyViewController = segue.destination as! StoryViewController
        if (story.storyContent.count == 0) {
            storyViewController.content = story.storyContent
            showNote()
        }
        else {
            storyViewController.content = story.storyContent
        }
        
    }
}

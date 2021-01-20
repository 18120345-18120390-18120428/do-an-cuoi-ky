//
//  InformationStoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/15/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift
import Alertift
class InformationStoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Khoi tao data manager
    var dbManager:DBManager!
    var dataList:Results<Item>!
    var Online = true
    var dataOffline:Item!
    var liked = false
    var rating = 0
    var storyName = ""
    var likes = 0
    var views = 0
    var arrayStory : [Story] = []
    var favoriteBook : [String] = []
    var listRating : [String : Int?] = [:]
    var arrRating : [String: Int] = [:]
    var img : String = ""
    private var story = Story()
    var ref: DatabaseReference!
    private var refHandle: DatabaseHandle!
    @IBOutlet weak var tableView: UITableView!
    var heightDescription: CGFloat = 100.0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        self.title = "Info"
        if(Online){
            fetchStory(name: storyName)
            fetchDataUser()
        }else{
            story.name = dataOffline.name
            story.author = dataOffline.author
            story.avatar = loadImageFromDiskWith(fileName: dataOffline.name)!
            story.category = dataOffline.category
            story.description = dataOffline.descript
            story.numberOfChapters = dataOffline.numberOfChapters
            for chapter in dataOffline.storyContent {
                let chapterOrder = chapter.chapterOrder
                let chapterName = chapter.chapterName
                let chapterContent = chapter.chapterContent
                let newChapter = Chapter()
                newChapter.addNewChapter(chapterOrder: chapterOrder, chapterName: chapterName, chapterContent: chapterContent)
                story.storyContent.append(newChapter)
            }
        }
        
        
    }
    func seen() {
        if(Online){
            let newViews = views + 1
            let ref1 = Database.database().reference().child("Stories/\(storyName)")
            ref1.removeAllObservers()
            ref1.updateChildValues(["views": newViews])
        }

    }
    @IBAction func actionBack(_ sender: Any) {
        self.Online = true
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
            print("Reload user info")
            self.tableView.reloadData()
        })
    }
    func fetchStory(name: String) {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        self.ref = Database.database().reference()
        ref.child("Stories").queryOrdered(byChild: "name").queryStarting(atValue: name).queryEnding(atValue: storyName+"\u{f8ff}").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                let author = storyDict["author"] as! String
                let category = storyDict["category"] as! String
                let urlImage = storyDict["avatar"] as! String
                self.img = urlImage
                let description = storyDict["description"] as! String
                let updateDay = storyDict["timestamp"] as! String
                var arrRating: [String: Int] = [:]
                if (storyDict["rating"] as? [String: Int] != nil) {
                    arrRating = storyDict["rating"] as! [String: Int]
                }
                self.likes = storyDict["likes"] as! Int
                self.views = storyDict["views"] as! Int
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
                newStory.rating = arrRating
                self.arrRating = arrRating
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
                print("reload story")
                self.arrayStory.append(newStory)
                self.story = self.arrayStory.first!
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
            var avgRating:Float = 0
            if (self.arrRating.count > 0) {
                var sum : Float = 0;
                for (_, value) in self.arrRating {
                    sum = sum + Float(value)
                }
                avgRating = sum / Float(self.arrRating.count)
            }
            
            cell.lbRating.text = "Điểm đánh giá: \(avgRating)/5"
            return cell
        }
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
            cell.itemLike.badgeValue = String(likes)
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
        if(Online){
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/rating/")
            ref.updateChildValues([
                "\(story.name)" : rating
            ])
            let ref1 = Database.database().reference().child("Stories/\(story.name)/rating")
            ref1.updateChildValues([
                "\(uid)" : rating
            ])
            self.arrRating["\(uid)"] = rating
        }
        tableView.reloadData()
    }
    
    func choseTwoStar() {
        rating = 2;
        if(Online){
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/rating/")
            ref.updateChildValues([
                "\(story.name)" : rating
            ])
            let ref1 = Database.database().reference().child("Stories/\(story.name)/rating")
            ref1.updateChildValues([
                "\(uid)" : rating
            ])
            self.arrRating["\(uid)"] = rating
        }
        tableView.reloadData()
    }
    
    func choseThreeStar() {
        rating = 3;
        if(Online){
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/rating/")
            ref.updateChildValues([
                "\(story.name)" : rating
            ])
            let ref1 = Database.database().reference().child("Stories/\(story.name)/rating")
            ref1.updateChildValues([
                "\(uid)" : rating
            ])
            self.arrRating["\(uid)"] = rating
        }
        tableView.reloadData()
    }
    
    func choseFourStar() {
        rating = 4;
        if(Online){
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/rating/")
            ref.updateChildValues([
                "\(story.name)" : rating
            ])
            let ref1 = Database.database().reference().child("Stories/\(story.name)/rating")
            ref1.updateChildValues([
                "\(uid)" : rating
            ])
            self.arrRating["\(uid)"] = rating
        }
        tableView.reloadData()
    }
    
    func choseFiveStar() {
        rating = 5;
        if(Online){
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/rating/")
            ref.updateChildValues([
                "\(story.name)" : rating
            ])
            let ref1 = Database.database().reference().child("Stories/\(story.name)/rating")
            ref1.updateChildValues([
                "\(uid)" : rating
            ])
            self.arrRating["\(uid)"] = rating
        }
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
            if(Online){
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let ref = Database.database().reference().child("Profile/\(uid)")
                ref.updateChildValues([
                    "favoriteBook": self.favoriteBook
                ])
                let ref2 = Database.database().reference().child("Stories/\(story.name)")
                ref2.updateChildValues([
                    "likes": likes
                ])
            }
                tableView.reloadData()
        } else if (item.title == "Bình luận") {
            if(Online){
                performSegue(withIdentifier: "commentInfo", sender: self)
            }
        }
        else if (item.title == "Chia sẻ") {
            print("chia sẻ")
            // Mô tả
            let firstActivityItem = story.name

            // Thiết lập url
            let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
            
            // If you want to use an image
            let image : UIImage = story.avatar
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.postToTwitter,
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        else if (item.title == "Tải xuống") {
            //Khoi tao dbManger
            dbManager = DBManager.sharedInstance
            //Lay ra danh sach du lieu
            dataList = dbManager.getDataFromDB()
            dataList = dataList.filter("name = '\(story.name)'")
            if( dataList.count == 0){
                 let item = Item()
                 item.name = story.name
                 item.author = story.author
                 item.category = story.category
                 item.descript = story.description
                 item.status = story.status
                 item.numberOfChapters = story.numberOfChapters
                 item.timestamp = story.timestamp
                 for chapter in story.storyContent{
                     let story = StoryContent()
                     story.chapterName = chapter.chapterName
                     story.chapterOrder = chapter.chapterOrder
                     story.chapterContent = chapter.chapterContent
                     item.storyContent.append(story);
                 }
                 saveImage(imageName: story.name,image: story.avatar)

                 DBManager.sharedInstance.addData(object: item)

                 Alertift.alert(title: "Success", message: "Tải về máy thành công!")
                 .action(.default("OK"))
                 .show(on: self)
            }else{
                Alertift.alert(title: "Failed", message: "Đã tải về máy")
                .action(.default("OK"))
                .show(on: self)
            }
            
        }
    }
    func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Kiểm tra nếu tồn tài thì xóa đi
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
            print("Save success")
        } catch let error {
            print("error saving file with error", error)
        }

    }
    func loadImageFromDiskWith(fileName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    func didTapReadStory() {
        self.seen()
        performSegue(withIdentifier: "readStory", sender: self)
    }
    func showNote() {
        
        let alert = UIAlertController(title: "Chưa có chương", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction.init(title: "Huỷ", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is StoryViewController
        {
            let storyViewController = segue.destination as! StoryViewController
            if (story.storyContent.count == 0) {
                showNote()
            }
            else {
                storyViewController.content = story.storyContent
                storyViewController.nameStory = story.name
                storyViewController.Online = Online
            }
        }
        else if segue.destination is CommentViewController {
            let commentViewController = segue.destination as! CommentViewController
            commentViewController.nameStory = story.name
        }
        
    }
}

//
//  CommentViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 1/16/21.
//  Copyright © 2021 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class CommentViewController: UIViewController {
    
    var nameStory:String = ""
    private var comments : [Comment] = []
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var tableViewCommnet: UITableView!
    @IBAction func sentComment(_ sender: Any) {
        let content = self.tfInput.text!
        sentComment(content: content)
    }
    @IBAction func actBack() {
        dismiss(animated: true, completion: nil)
    }
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCommnet.delegate = self
        tableViewCommnet.dataSource = self
        print("reload")
        getlistComment()
        
        self.tableViewCommnet.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    var urlAvatar : String!
    var currentUsername: String!
    func sentComment(content: String) {
        ref = Database.database().reference()
        if (content == "") {
            Alertift.alert(title: "Failed", message: "Vui lòng nhập nội dung")
            .action(.default("OK"))
            .show(on: self)
        } else {
            let userID = Auth.auth().currentUser?.uid
            
            ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Lấy giá trị của user
                let value = snapshot.value as? NSDictionary
                let urlImage = value?["photoURL"] as? String ?? ""
                self.urlAvatar = urlImage
                self.currentUsername = value?["username"] as? String ?? ""
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                let result = formatter.string(from: date)
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)
                let object: [String: Any] = [
                    "userID" : userID ?? "",
                    "username" : self.currentUsername ?? "",
                    "urlAvatar": self.urlAvatar ?? "",
                    "content" : content,
                    "date": result
                ]
                let comment = Comment()
                comment.username = self.currentUsername ?? ""
                comment.content = content
                comment.timestamp = result
                comment.avatar = image
                self.comments.append(comment)
                self.tableViewCommnet.reloadData()
                self.ref = self.ref.child("Stories/\(self.nameStory)/comment")
                self.ref.childByAutoId().setValue(object)
            })
        }
    }
    // Phan lay du lieu
    var currentKey = ""
    var currentName = ""
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        return footerView
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - currentOffset < 150) {
            getlistComment()
        }
    }
    func getlistComment() {
        if (currentKey == "") {
            // add the spinner view controller
            let child = SpinnerViewController()
            addChild(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParent: self)
            ref = Database.database().reference()
            ref.child("Stories/\(nameStory)/comment").queryOrdered(byChild: "date").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: {snapshot in
                var last: DataSnapshot
                if (snapshot.children.allObjects.last as? DataSnapshot != nil) {
                    last = snapshot.children.allObjects.last as! DataSnapshot
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        // then remove the spinner view controller
                        child.willMove(toParent: nil)
                        child.view.removeFromSuperview()
                        child.removeFromParent()
                    }
                    return
                }
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let storyDict = snap.value as! [String: Any]
                    let username = storyDict["username"] as! String
                    let content = storyDict["content"] as! String
                    let urlImage = storyDict["urlAvatar"] as! String
                    let date = storyDict["date"] as! String
                    let url = URL(string: urlImage)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!, scale: UIScreen.main.scale)
                    let comment = Comment()
                    comment.username = username
                    comment.content = content
                    comment.timestamp = date
                    comment.avatar = image
                    self.comments.append(comment)
                }
                self.currentKey = last.key
                self.currentName = last.childSnapshot(forPath: "date").value as! String
                print("reload comment")
                self.tableViewCommnet.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    // then remove the spinner view controller
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
            })
        } else {
            self.tableViewCommnet.tableFooterView = self.createSpinnerFooter()
            print(currentName)
            ref.child("Stories/\(nameStory)/comment").queryOrdered(byChild: "date").queryStarting(atValue: currentName).queryLimited(toFirst: 11).observeSingleEvent(of: .value, with: {snapshot in
                let last = snapshot.children.allObjects.last as! DataSnapshot
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    if (snap.key != self.currentKey) {
                        let snap = child as! DataSnapshot
                        let storyDict = snap.value as! [String: Any]
                        let username = storyDict["username"] as! String
                        let content = storyDict["content"] as! String
                        let urlImage = storyDict["urlAvatar"] as! String
                        let date = storyDict["date"] as! String
                        let url = URL(string: urlImage)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!, scale: UIScreen.main.scale)
                        let comment = Comment()
                        comment.username = username
                        comment.content = content
                        comment.timestamp = date
                        comment.avatar = image
                        self.comments.append(comment)
                    }
                    
                }
                self.currentKey = last.key
                self.currentName = last.childSnapshot(forPath: "date").value as! String
                print("reload comment")
                self.tableViewCommnet.reloadData()
                DispatchQueue.main.async {
                    self.tableViewCommnet.tableFooterView = nil
                }
            })
        }
    }
    
}
extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        cell.avatar.image = comments[indexPath.row].avatar
        cell.lbUsername.text = comments[indexPath.row].username
        cell.lbContent.text = comments[indexPath.row].content
        cell.lbStampTime.text = comments[indexPath.row].timestamp
        return cell
    }
    
    
}

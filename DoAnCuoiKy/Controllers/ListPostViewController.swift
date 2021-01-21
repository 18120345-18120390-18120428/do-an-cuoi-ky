//
//  ListPostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class ListPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var tableView: UITableView!
    private var data: [Story] = []
    private var storyName : [String] = []
    private var favoriteBook: [String] = []
    var ref = Database.database().reference()
    var indexUpdate = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Khoi tao navigation
        navigationController?.navigationBar.barTintColor = UIColor.darkText
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        // Khai báo Table View
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        getPublishStories()
        fetchFavorite()
    }
    func getPublishStories() {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            if (snapshot.hasChild("publishStory")) {
                self.storyName = value?["publishStory"] as! [String]
            }
            for name in self.storyName {
                self.fetchDataStory(name: name)
            }
            self.tableView.reloadData()
        })
    }
    func fetchDataStory(name: String) {
        let ref = Database.database().reference()
        ref.child("Stories").child(name).observeSingleEvent(of: .value, with: { (snapshot) in
            let storyDict = snapshot.value as! [String: Any]
            let name = storyDict["name"] as! String
            let newStory: Story = Story()
            newStory.name = name
            self.data.append(newStory)
            self.tableView.reloadData()
        })
        
    }
    func fetchFavorite() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if (snapshot.hasChild("favoriteBook")) {
                self.favoriteBook = value?["favoriteBook"] as! [String]
            }
        })
    }
    // Phần Trở về trang chủ
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Thêm truyện
    @IBAction func actionAddStory(_ sender: Any) {
        indexUpdate = -1
        performSegue(withIdentifier: "PostViewController", sender: self)
    }
    // Phần TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPostCell") as! ListPostTableViewCell
        cell.lbTittle.text = data[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            data.remove(at: indexPath.item)
            let deleteStory = storyName[indexPath.item]
            storyName.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let ref = Database.database().reference().child("Profile/\(uid)/publishStory")
            ref.setValue(storyName)
            
            let ref1 = Database.database().reference().child("Stories/\(deleteStory)")
            ref1.removeValue()
            let ref2 = Database.database().reference().child("Profile/\(uid)/favoriteBook")
            if let index = favoriteBook.firstIndex(of: "\(deleteStory)") {
                favoriteBook.remove(at: index)
            }
            ref2.setValue(favoriteBook)
            let ref3 = Database.database().reference().child("Profile/\(uid)/rating/\(deleteStory)")
            ref3.removeValue()
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexUpdate = indexPath.row
        performSegue(withIdentifier: "PostViewController", sender: self)
    }
    // Chọn 1 dòng
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postViewController = segue.destination as! PostViewController
        postViewController.delegate = self
        if (indexUpdate > -1) {
            postViewController.storyName = data[indexUpdate].name
        }
    }
    // Phần Xoá, sửa truyện
}

extension ListPostViewController: PostViewControllerDelegate {
    func addNewStory(newStory: Story) {
        for index in 0..<data.count {
            if (data[index].name == newStory.name) {
                data[index] = newStory
                return
            }
        }
        data.append(newStory)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        storyName.append(newStory.name)
        let ref = Database.database().reference().child("Profile/\(uid)/publishStory")
        print(storyName)
        ref.setValue(storyName)
        tableView.reloadData()
    }
}

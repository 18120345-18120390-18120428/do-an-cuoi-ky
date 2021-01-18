//
//  DetailCategoryViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/31/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class DetailCategoryViewController: UIViewController {
    var titile = ""
    private var data: [Story] = []
    var indexUpdate = -1
    @IBOutlet weak var tableView: UITableView!
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.darkText
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        self.title = title
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tabBarController?.tabBar.isHidden = true
        fetchStories()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    var currentKey = ""
    var currentName = ""
    func fetchStories() {
        if (currentKey == "") {
            let child = SpinnerViewController()
            addChild(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParent: self)
            ref.child("Stories").queryOrdered(byChild: "category").queryEqual(toValue: title).queryLimited(toFirst: 10).observe(.value, with: {snapshot in
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
                    let name = storyDict["name"] as! String
                    let author = storyDict["author"] as! String
                    let urlImage = storyDict["avatar"] as! String
                    let updateDay = storyDict["timestamp"] as! String
                    let newStory: Story = Story()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let date = dateFormatter.date(from:updateDay)!
                    newStory.timestamp = date
                    let url = URL(string: urlImage)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                    newStory.addSimpleStory(name: name, author: author, category: "", avatar: image)
                    self.data.append(newStory)
                }
                self.currentKey = last.key
                self.currentName = last.childSnapshot(forPath: "name").value as! String
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    // then remove the spinner view controller
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
            })
        } else {
            ref.child("Stories").queryOrdered(byChild: "name").queryStarting(atValue: currentName).queryLimited(toFirst: 11).observe(.value, with: {snapshot in
                let last = snapshot.children.allObjects.last as! DataSnapshot
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot
                    if (snap.key != self.currentKey) {
                        let snap = child as! DataSnapshot
                        let storyDict = snap.value as! [String: Any]
                        let name = storyDict["name"] as! String
                        let author = storyDict["author"] as! String
                        let urlImage = storyDict["avatar"] as! String
                        let updateDay = storyDict["timestamp"] as! String
                        let newStory: Story = Story()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy"
                        let date = dateFormatter.date(from:updateDay)!
                        newStory.timestamp = date
                        let url = URL(string: urlImage)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                        newStory.addSimpleStory(name: name, author: author, category: "", avatar: image)
                        self.data.append(newStory)
                    }
                }
                self.currentKey = last.key
                self.currentName = last.childSnapshot(forPath: "name").value as! String
                self.tableView.reloadData()
            })
        }
        
    }
}

extension DetailCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VVTableCell") as! VVTableViewCell
        
        // Giao diện Avatar
        cell.logoItem.layer.cornerRadius = 40.0
        cell.logoItem.image = data[indexPath.row].avatar
        cell.lbName.text = data[indexPath.row].name
        cell.lbAuthor.text = data[indexPath.row].author
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: data[indexPath.row].timestamp)
        cell.lbUpdateDay.text = "Ngày cập nhật: \(date)"
        cell.lbChapterNumber.text = "Số Chương: \(data[indexPath.row].numberOfChapters)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexUpdate = indexPath.row
        print("index update: \(self.indexUpdate)")
        performSegue(withIdentifier: "categoryStory", sender: self)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - currentOffset < 100) {
            fetchStories()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoStoryViewController = segue.destination as! InformationStoryViewController
        print("Story name: \(data[indexUpdate].name)")
        InfoStoryViewController.storyName = data[indexUpdate].name
    }
}

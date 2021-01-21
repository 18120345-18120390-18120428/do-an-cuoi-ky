//
//  Top10likesViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 1/19/21.
//  Copyright © 2021 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class Top10likesViewController: UIViewController {
    var titile = ""
    private var data: [Story] = []
    var indexUpdate = -1
    @IBOutlet weak var tableView: UITableView!
    @IBAction func actBack() {
        dismiss(animated: true, completion: nil)
    }
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = title
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tabBarController?.tabBar.isHidden = true
        fetchStories()
    }
    func fetchStories() {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        ref.child("Stories").queryOrdered(byChild: "likes").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                let author = storyDict["author"] as! String
                let numberOfChapters = storyDict["numberOfChapters"] as! Int
                let urlImage = storyDict["avatar"] as! String
                let likes = storyDict["likes"] as! Int
                let newStory: Story = Story()
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                newStory.addSimpleStory(name: name, author: author, category: "", avatar: image)
                newStory.numberOfChapters = numberOfChapters
                newStory.likes = likes
                self.data.append(newStory)
            }
            self.data.reverse()
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        })
    }
}

extension Top10likesViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.lbUpdateDay.text = "Lượt thích: \(data[indexPath.row].likes)"
        cell.lbChapterNumber.text = "Số Chương: \(data[indexPath.row].numberOfChapters)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexUpdate = indexPath.row
        print("index update: \(self.indexUpdate)")
        performSegue(withIdentifier: "top10likes", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoStoryViewController = segue.destination as! InformationStoryViewController
        print("Story name: \(data[indexUpdate].name)")
        InfoStoryViewController.storyName = data[indexUpdate].name
    }
}

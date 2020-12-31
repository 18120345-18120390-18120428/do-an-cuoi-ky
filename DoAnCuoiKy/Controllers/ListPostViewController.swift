//
//  ListPostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var tableView: UITableView!
    private var data: [Story] = []
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
        
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        ref.child("Stories").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                let author = storyDict["author"] as! String
                let category = storyDict["category"] as! String
                let urlImage = storyDict["avatar"] as! String
                let description = storyDict["description"] as! String
                let newStory: Story = Story()
                
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
                self.data.append(newStory)
            }
            
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("Simulation finished")
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
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
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPostCell") as! ListPostTableViewCell
        cell.avatar.image = data[indexPath.row].avatar
        cell.lbTittle.text = data[indexPath.row].name
    
        return cell
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
            postViewController.newStory = data[indexUpdate]
        }
    }
    // Phần Xoá, sửa truyện
}

extension ListPostViewController: PostViewControllerDelegate {
    func addNewStory(newStory: Story) {
        print(newStory)
        data.append(newStory)
        tableView.reloadData()
    }
}

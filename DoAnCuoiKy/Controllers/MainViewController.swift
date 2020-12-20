//
//  MainViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var listStory: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var data: [Story] = []
    var ref = Database.database().reference()
    var indexUpdate = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hiển thị danh sách hiện tại

        // Khai báo Table view
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
                let updateDay = storyDict["timestamp"] as! String
                let newStory: Story = Story()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let date = dateFormatter.date(from:updateDay)!
                newStory.timestamp = date
                
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                newStory.addSimpleStory(name: name, author: author, category: category, avatar: image)
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
                newStory.chapterNumber = newStory.storyContent.count
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
    
    // Phần TableView
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
        print("date: \(date)")
        cell.lbUpdateDay.text = date
        cell.lbChapterNumber.text = "Số Chương: \(data[indexPath.row].chapterNumber)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexUpdate = indexPath.row
        performSegue(withIdentifier: "MainViewController", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoStoryViewController = segue.destination as! InformationStoryViewController
        InfoStoryViewController.story = data[indexUpdate]
    }
    // Phần Slide Menu
    @IBAction func goToMenu(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let dest = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        dest.modalPresentationStyle = .overCurrentContext
        present(dest, animated: false, completion: nil)
    }
    
    // Nút Search
    @IBAction func action_search(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let search = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        search.modalPresentationStyle = .fullScreen
        self.present(search, animated: true, completion: nil)
    }
    
    // Nút Reload
    @IBAction func action_reload(_ sender: Any) {
        
    }
    
    // Nút Pushlist
    @IBAction func action_pushlist(_ sender: Any) {
    }
}

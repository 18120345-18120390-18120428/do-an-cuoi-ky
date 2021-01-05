//
//  MainViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var listStory: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var data: [Story] = []
    var ref = Database.database().reference()
    var indexUpdate = -1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khai báo Table view
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        // add side menu
        sideMenu.leftSide = true
        sideMenu.setNavigationBarHidden(true, animated: false)
        let model: SideMenuPresentationStyle = .menuSlideIn
        var settings = SideMenuSettings()
        settings.presentationStyle = model
        sideMenu.settings = settings
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        fetchStories()
        
    }
    // Phan lay du lieu
    var currentKey = ""
    var currentName = ""
    func fetchStories() {
        // add the spinner view controller
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        if (currentKey == "") {
            ref.child("Stories").queryOrdered(byChild: "name").queryLimited(toFirst: 10).observe(.value, with: {snapshot in
                let last = snapshot.children.allObjects.last as! DataSnapshot
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let storyDict = snap.value as! [String: Any]
                    let name = storyDict["name"] as! String
                    let author = storyDict["author"] as! String
                    let urlImage = storyDict["avatar"] as! String
                    let updateDay = storyDict["timestamp"] as! String
                    let numberOfChapters = storyDict["numberOfChapters"] as! Int
                    let newStory: Story = Story()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let date = dateFormatter.date(from:updateDay)!
                    newStory.timestamp = date
                    let url = URL(string: urlImage)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!, scale: UIScreen.main.scale)
                    newStory.addSimpleStory(name: name, author: author, category: "", avatar: image!)
                    newStory.numberOfChapters = numberOfChapters
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
                        let numberOfChapters = storyDict["numberOfChapters"] as! Int
                        let newStory: Story = Story()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy"
                        let date = dateFormatter.date(from:updateDay)!
                        newStory.timestamp = date
                        let url = URL(string: urlImage)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                        newStory.addSimpleStory(name: name, author: author, category: "", avatar: image)
                        newStory.numberOfChapters = numberOfChapters
                        self.data.append(newStory)
                    }
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
        }
        
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
        performSegue(withIdentifier: "MainViewController", sender: self)
    }
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
        if (maxOffset - currentOffset < 100) {
            fetchStories()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoStoryViewController = segue.destination as! InformationStoryViewController
        print("Story name: \(data[indexUpdate].name)")
        InfoStoryViewController.storyName = data[indexUpdate].name
    }
    // Phần Slide Menu
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
    @IBAction func tapSideMenu() {
        present(sideMenu, animated: true)
    }

    
    // Nút Search
    @IBAction func action_search(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = sb.instantiateViewController(withIdentifier: "SearchViewController")
        let navController = UINavigationController(rootViewController: VC1)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
    
    // Nút Reload
    @IBAction func action_reload(_ sender: Any) {
        data.removeAll()
        currentName = ""
        currentKey = ""
        fetchStories();
    }
    
    // Nút Pushlist
    @IBAction func action_pushlist(_ sender: Any) {
    }
}

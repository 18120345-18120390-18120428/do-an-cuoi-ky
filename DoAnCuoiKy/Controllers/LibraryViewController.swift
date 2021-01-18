//
//  LibraryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/12/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

class LibraryViewController: UIViewController {
    
    var favoriteBook : [String] = []
    var indexFavoriteBook = -1;
    var downloadBook : [String] = []
    var dataFavoriteStory : [Story] = []
    var dataDownloadStory : [Story] = []
    @IBAction func segmentChange(_ sender: Any) {
        print("hihi")
        tableView.reloadData()
    }
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // add side menu
        sideMenu.leftSide = true
        sideMenu.setNavigationBarHidden(true, animated: false)
        let model: SideMenuPresentationStyle = .menuSlideIn
        var settings = SideMenuSettings()
        settings.presentationStyle = model
        sideMenu.settings = settings
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        fetchDataUser()
    }
    func fetchDataUser() {
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            if (snapshot.hasChild("favoriteBook")) {
                self.favoriteBook = value?["favoriteBook"] as! [String]
            }
            print(self.favoriteBook)
            for storyName in self.favoriteBook {
                self.fetchDataStory(name: storyName)
            }
            self.tableView.reloadData()
        })
    }
    // Phần Slide Menu
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
    @IBAction func tapSideMenu() {
        present(sideMenu, animated: true)
    }
    func fetchDataStory(name: String) {
        let ref = Database.database().reference()
        ref.child("Stories").child(name).observeSingleEvent(of: .value, with: { (snapshot) in
            let storyDict = snapshot.value as! [String: Any]
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
            self.dataFavoriteStory.append(newStory)
            self.tableView.reloadData()

        })
        
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segment.selectedSegmentIndex == 0) {
            return dataFavoriteStory.count
        }
        return dataDownloadStory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VVTableCell") as! VVTableViewCell
        cell.logoItem.layer.cornerRadius = 40.0
        cell.logoItem.image = dataFavoriteStory[indexPath.row].avatar
        cell.lbName.text = dataFavoriteStory[indexPath.row].name
        cell.lbAuthor.text = dataFavoriteStory[indexPath.row].author
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: dataFavoriteStory[indexPath.row].timestamp)
        cell.lbUpdateDay.text = "Ngày cập nhật: \(date)"
        cell.lbChapterNumber.text = "Số Chương: \(dataFavoriteStory[indexPath.row].numberOfChapters)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexFavoriteBook = indexPath.row
        performSegue(withIdentifier: "favoriteBook", sender: self)
    }
    // Chọn 1 dòng
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let informationStoryViewController = segue.destination as! InformationStoryViewController
        if (indexFavoriteBook > -1) {
            informationStoryViewController.storyName = dataFavoriteStory[indexFavoriteBook].name
        }
    }
}

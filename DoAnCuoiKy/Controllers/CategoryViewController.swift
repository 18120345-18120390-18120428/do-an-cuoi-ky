//
//  CategoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/11/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import SideMenu

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var tableView: UITableView!
    var categoryUpdate = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khai báo Table View
        tableView.delegate = self
        tableView.dataSource = self
        
        // add side menu
        sideMenu.leftSide = true
        sideMenu.setNavigationBarHidden(true, animated: false)
        let model: SideMenuPresentationStyle = .menuSlideIn
        var settings = SideMenuSettings()
        settings.presentationStyle = model
        sideMenu.settings = settings
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    // Phần Slide Menu
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
    @IBAction func tapSideMenu() {
        present(sideMenu, animated: true)
    }
    @IBAction func action_slidemenu(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let dest = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        dest.modalPresentationStyle = .overCurrentContext
        present(dest, animated: false, completion: nil)
    }
    
    // Mang chứa tên Thể loại
    let category = ["Ngôn Tình", "Kiếm Hiệp", "Truyện Teen", "Truyện Ma", "Quân Sự", "Trinh Thám", "Lịch Sử", "Tiểu Thuyết", "Thiếu Nhi", "Truyện Ngắn", "Truyện Cười", "Cổ Tích", "Nước Ngoài", "Khoa Học","Truyện Voz"]
    
    // Phần Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count / 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        cell.btnCategory1.setTitle(category[indexPath.row * 2 ], for: .normal)
        cell.btnCategory2.setTitle(category[indexPath.row * 2 + 1], for: .normal)
        cell.delegate = self
        return cell
    }
}

extension CategoryViewController: CategoryTableViewCellDelegate {
    func tapCate1(text: String) {
        categoryUpdate = text
        performSegue(withIdentifier: "passCategory", sender: self)
    }
    
    func tapCate2(text: String) {
        categoryUpdate = text
        performSegue(withIdentifier: "passCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailCategoryViewController = segue.destination as! DetailCategoryViewController
        detailCategoryViewController.title = categoryUpdate
        
    }
}

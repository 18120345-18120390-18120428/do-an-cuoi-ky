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
    @IBOutlet weak var outlet_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khai báo Table View
        outlet_tableview.delegate = self
        outlet_tableview.dataSource = self
        
        // add side menu
        sideMenu.leftSide = true
        sideMenu.setNavigationBarHidden(true, animated: false)
        let model: SideMenuPresentationStyle = .menuSlideIn
        var settings = SideMenuSettings()
        settings.presentationStyle = model
        sideMenu.settings = settings
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
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
        return category.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = outlet_tableview.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        
        // Nội dung cell
        cell.outlet_categorylabel.text = category[indexPath.row]
        
        // Giao diện Avatar
        cell.outlet_categoryavatar.layer.cornerRadius = 50.0
        
        // Giao diện View Cell
        cell.outlet_viewcell.layer.borderWidth = 3.0
        cell.outlet_viewcell.layer.borderColor = UIColor.white.cgColor
        cell.outlet_viewcell.layer.cornerRadius = 50.0
        
        return cell
    }

}

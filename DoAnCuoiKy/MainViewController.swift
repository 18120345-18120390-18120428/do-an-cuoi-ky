//
//  MainViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_danhsach: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hiển thị danh sách hiện tại

        // Khai báo Table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Phần TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VVTableCell") as! VVTableViewCell
        
        // Giao diện Avatar
        cell.logoItem.layer.cornerRadius = 40.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let story = sb.instantiateViewController(withIdentifier: "InformationStoryViewController") as! InformationStoryViewController
        story.modalPresentationStyle = .fullScreen
        self.present(story, animated: true, completion: nil)
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

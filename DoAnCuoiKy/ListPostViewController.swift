//
//  ListPostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class ListPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Khai báo Table View
        outlet_tableview.delegate = self
        outlet_tableview.dataSource = self
    }
    
    // Phần Trở về trang chủ
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Thêm truyện
    @IBAction func action_themtruyen(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let post = sb.instantiateViewController(identifier: "PostViewController") as! PostViewController
        post.modalPresentationStyle = .fullScreen
        self.present(post, animated: false, completion: nil)
    }
    
    // Phần TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPostCell") as! ListPostTableViewCell
    
        // Giao diện Avatar
        cell.outlet_logoitem.layer.cornerRadius = 50.0
    
        return cell
    }
    
    // Phần Xoá, sửa truyện
    
}

//
//  SideMenuController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/25/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class SideMenuController: UITableViewController {

    var item = ["Truyện yêu thích", "Truyện xem nhiều", "Truyện mới đăng", "Đăng truyện"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UserInfoTableViewCell.nib(), forCellReuseIdentifier: UserInfoTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as! UserInfoTableViewCell
            cell.configure(with: "avatar")
            cell.renameLb(with: "Username")
            return cell;
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row - 1]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 4) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let VC1 = sb.instantiateViewController(withIdentifier: "ListPostViewController")
            let navController = UINavigationController(rootViewController: VC1)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated:true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 160
        }
        return 30
    }
}

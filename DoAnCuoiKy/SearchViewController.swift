//
//  SearchViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Phần Search

}

//
//  LibraryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/12/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // Các biến quản lý đối tượng

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Phần Slide Menu
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
    
    // Phần Lịch sử
    
    // Phần Tải về
    
}

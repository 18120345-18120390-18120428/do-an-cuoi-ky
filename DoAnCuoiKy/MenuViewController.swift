//
//  MenuViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/7/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius = 0.5 * avatar.bounds.size.width
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBAction func exit(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
    @IBAction func topStory(_ sender: Any) {
        // nhấn nút truyện xem nhiều
    }
    @IBAction func newStory(_ sender: Any) {
        // nhấn dút truyện mới đăng
    }
    @IBAction func favoriteStory(_ sender: Any) {
        // nhấn nút truyện yêu thích
    }
    @IBAction func publishStory(_ sender: Any) {
        // nhân nút đăng truyện
    }
    
}

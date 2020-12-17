//
//  MenuViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/7/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Giao diện Avatar
        avatar.layer.cornerRadius = 0.5 * avatar.bounds.size.width
        
        // Hiển thị tên User
    }
    
    // Nút Exit
    @IBAction func exit(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
    
    // nhấn nút truyện xem nhiều
    @IBAction func topStory(_ sender: Any) {
    }
    
    // nhấn dút truyện mới đăng
    @IBAction func newStory(_ sender: Any) {
    }
    
    // nhấn nút truyện yêu thích
    @IBAction func favoriteStory(_ sender: Any) {
    }
    
    // nhấn nút đăng truyện
    @IBAction func publishStory(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let dangTruyen = sb.instantiateViewController(identifier: "ListPostViewController")
        dangTruyen.modalPresentationStyle = .fullScreen
        self.present(dangTruyen, animated: true, completion: nil)
    }
    
}

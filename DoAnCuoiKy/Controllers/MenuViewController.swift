//
//  MenuViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/7/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
class MenuViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        // Giao diện Avatar
        avatar.layer.cornerRadius = 0.5 * avatar.bounds.size.width
        
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            let urlImage = value?["photoURL"] as? String ?? ""
            if urlImage == ""{
                self.avatar.image = #imageLiteral(resourceName: "avatar")
            }else{
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                self.avatar.image = image
            }
                  
            let username = value?["username"] as? String ?? ""
            self.name.text! = username
        })
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

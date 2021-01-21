//
//  InformationViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
class InformationViewController: UIViewController {
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var outlet_avatar: UIImageView!
    @IBOutlet weak var outlet_tenuser: UILabel!
    @IBOutlet weak var outlet_mail: UILabel!
    @IBOutlet weak var outlet_gioitinh: UILabel!
    @IBOutlet weak var outlet_ngaysinh: UILabel!
    @IBOutlet weak var outlet_ngaythamgia: UILabel!
    @IBOutlet weak var outlet_chucdanh: UIImageView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Giao diện Avatar
        outlet_avatar.layer.cornerRadius = 0.5 * outlet_avatar.bounds.size.width
        
        // Hiển thị nội dung tài khoản
    }
    override func viewWillAppear(_ animated: Bool) {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            let urlImage = value?["photoURL"] as? String ?? ""
            if urlImage == ""{
                self.outlet_avatar.image = #imageLiteral(resourceName: "avatar")
            }else{
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                self.outlet_avatar.image = image
            }
           
            let username = value?["username"] as? String ?? ""
            if username == ""{
                self.outlet_tenuser.text! = "Vui lòng cập nhập"
            }else{
                self.outlet_tenuser.text! = username
            }
            
            let gender = value?["gender"] as? String ?? ""
            if gender == ""{
                self.outlet_gioitinh.text! = "Giới tính: Vui lòng cập nhập"
            }else{
                self.outlet_gioitinh.text! = "Giới tính: " + gender
            }
            let dateOfBirth = value?["dateOfbirth"] as? String ?? ""
            if dateOfBirth == ""{
                self.outlet_ngaysinh.text! = "Ngày sinh: Vui lòng cập nhập"
            }else{
                 self.outlet_ngaysinh.text! = "Ngày sinh: " + dateOfBirth
            }
            let email = value?["email"] as? String ?? ""
            if email == ""{
                self.outlet_mail.text! = "Email : Vui lòng cập nhập"
            }else{
                 self.outlet_mail.text! = "Email: " + email
            }
            let joinDate = value?["joinDate"] as? String ?? ""
            self.outlet_ngaythamgia.text! = "Ngày tham gia: " + joinDate
            let position = value?["position"] as? String ?? ""
            if position == "Admin"{
                self.outlet_chucdanh.image = #imageLiteral(resourceName: "admin")
            }else{
                self.outlet_chucdanh.image = #imageLiteral(resourceName: "member")
            }
            

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    // Phần Trở về
    @IBAction func action_trove(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func EditProfile(_ sender: Any) {
        let dest = storyboard?.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
        dest.modalPresentationStyle = .fullScreen
        present(dest, animated: false, completion: nil)
    }
    
}

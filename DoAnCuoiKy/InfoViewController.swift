//
//  InfoViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/7/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class InfoViewController: UIViewController {

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
    
    // Phần Thông tin tài khoản
    @IBAction func action_tttk(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let thongTin = sb.instantiateViewController(withIdentifier: "InformationViewController")
        thongTin.modalPresentationStyle = .fullScreen
        self.present(thongTin, animated: true, completion: nil)
    }
    
    // Phần Đổi mật khẩu
    @IBAction func action_dmk(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let doiMatKhau = sb.instantiateViewController(withIdentifier: "ChangePasswordViewController")
        doiMatKhau.modalPresentationStyle = .fullScreen
        self.present(doiMatKhau, animated: true, completion: nil)
    }
    
    // Phần Thông tin ứng dụng
    @IBAction func action_vvtruyen(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vVTruyen = sb.instantiateViewController(withIdentifier: "VVTruyenViewController")
        vVTruyen.modalPresentationStyle = .fullScreen
        self.present(vVTruyen, animated: true, completion: nil)
    }
    
    // Phần Đăng Xuất
    @IBAction func btnLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            let src = self.storyboard?.instantiateViewController(withIdentifier: "ViewScreen")
            src!.modalPresentationStyle = .fullScreen
            self.present(src!, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            Alertift.alert(title: "Error", message: "Error logout")
            .action(.default("OK"))
            .show(on: self)
        }
    }
}

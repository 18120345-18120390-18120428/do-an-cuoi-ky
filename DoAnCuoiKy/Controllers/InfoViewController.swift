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
import SideMenu

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // add side menu
        sideMenu.leftSide = true
        sideMenu.setNavigationBarHidden(true, animated: false)
        let model: SideMenuPresentationStyle = .menuSlideIn
        var settings = SideMenuSettings()
        settings.presentationStyle = model
        sideMenu.settings = settings
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
   // Phần Slide Menu
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuController())
    @IBAction func tapSideMenu() {
        present(sideMenu, animated: true)
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
            let src = self.storyboard?.instantiateViewController(withIdentifier: "homeview")
            src!.modalPresentationStyle = .fullScreen
           // self.dismiss(animated: true, completion: nil)
            self.present(src!, animated: true, completion: nil)
           
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            Alertift.alert(title: "Error", message: "Error logout")
            .action(.default("OK"))
            .show(on: self)
        }
    }
}

    
  

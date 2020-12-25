//
//  LibraryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/12/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import SideMenu

class LibraryViewController: UIViewController {
    
    // Các biến quản lý đối tượng

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
    
    // Phần Lịch sử
    
    // Phần Tải về
    
}

//
//  ViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/2/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnDangKy(_ sender: Any) {
        let src = self.storyboard?.instantiateViewController(withIdentifier: "RegisViewController") as! RegisViewController
        src.modalPresentationStyle = .fullScreen
        self.present(src, animated: true, completion: nil)
        print("Chuyen sang man hinh dang ky")
    }
    @IBAction func btnDangNhap(_ sender: Any) {
        let src = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        src.modalPresentationStyle = .fullScreen
        self.present(src, animated: true, completion: nil)
        print("Chuyen sang man hinh dang nhap")
    }
    

}


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
<<<<<<< HEAD
   
=======
    @IBAction func btnDangKy(_ sender: Any) {
        let src = self.storyboard?.instantiateViewController(withIdentifier: "RegisViewController") as! RegisViewController
        src.modalPresentationStyle = .fullScreen
        self.present(src, animated: true, completion: nil)
        print("Chuyen sang man hinh dang ky")
    }
    @IBAction func btnDangNhap(_ sender: Any) {
        let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        src!.modalPresentationStyle = .fullScreen
        self.present(src!, animated: true, completion: nil)
        print("Chuyen sang man hinh dang nhap")
    }
    
>>>>>>> 5ae4651fcc09b9922b95028676ce4a43b0927e24

}


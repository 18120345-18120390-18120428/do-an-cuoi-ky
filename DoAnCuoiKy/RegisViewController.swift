//
//  RegisViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class RegisViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfCheckPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDangKy(_ sender: Any) {
        if (tfEmail.text!.isEmpty)
        {
            //alert
            return
        }
        if tfPass.text!.isEmpty {
            //alert
                       return
        }
        if tfCheckPass.text!.isEmpty {
            //alert
                       return
        }
        if( tfCheckPass.text! == tfPass.text!)
        {
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPass.text!) { authResult, error in
                     // ...
                   }
        }else {
            //alert nhap sai
            return
        }
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

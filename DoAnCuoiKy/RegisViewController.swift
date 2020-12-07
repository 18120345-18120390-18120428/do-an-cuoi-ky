//
//  RegisViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
<<<<<<< HEAD
import Alertift
=======

>>>>>>> 5ae4651fcc09b9922b95028676ce4a43b0927e24
class RegisViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfCheckPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
<<<<<<< HEAD
    @IBAction func btnDangKy(_ sender: Any) {
        if tfEmail.text!.isEmpty{
            Alertift.alert(title: "Error", message: "Please press email!")
            .action(.default("OK"))
            .show(on: self)
           
            return
        }
        if tfPass.text!.isEmpty{
           Alertift.alert(title: "Error", message: "Please press password!")
            .action(.default("OK"))
            .show(on: self)
            
            return
        }
        if tfCheckPass.text!.isEmpty{
            Alertift.alert(title: "Error", message: "Please press check password!")
            .action(.default("OK"))
            .show(on: self)
            
            return
        }
        if tfPass.text! == tfCheckPass.text! {
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPass.text!) { authResult, error in
                guard let user = authResult?.user, error == nil else{
                    print("Error : \(error!.localizedDescription)")
                    Alertift.alert(title: "Error", message: error?.localizedDescription)
                    .action(.default("OK"))
                    .show(on: self)
                    return
                }
                Alertift.alert(title: "Congratulations!", message: "You have successfully registered!")
                .action(.default("OK"))
                .show(on: self)
                let src = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                src.modalPresentationStyle = .fullScreen
                self.present(src, animated: true, completion: nil)
            }
        }
    }
    

=======
    
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
    
>>>>>>> 5ae4651fcc09b9922b95028676ce4a43b0927e24
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

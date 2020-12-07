//
//  LoginViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // kiem tra xem user da dang nhap chua, neu dang nhap roi chuyen sang man hinh trang chu
         Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Da dang nhap !")
                let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self.present(src!, animated: true, completion: nil)
            }
         }
    }
    @IBAction func btnLogin(_ sender: Any) {
        //Kiem tra dang nhap hop le
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
                Alertift.alert(title: "Error", message: error.localizedDescription)
                .action(.default("OK"))
                .show(on: self)
                return
            }
            if Auth.auth().currentUser != nil {
                print(Auth.auth().currentUser?.uid)
                let src = self?.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self!.present(src!, animated: true, completion: nil)
                
            }
        }
       
    }
    
    @IBAction func btnRegis(_ sender: Any) {
        let src = self.storyboard?.instantiateViewController(withIdentifier: "RegisViewController") as! RegisViewController
                      src.modalPresentationStyle = .fullScreen
                      self.present(src, animated: true, completion: nil)
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

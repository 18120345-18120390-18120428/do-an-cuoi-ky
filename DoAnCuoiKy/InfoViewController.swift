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
    
    @IBAction func btnLogout(_ sender: Any) {
         let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          let src = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
          src!.modalPresentationStyle = .fullScreen
          self.present(src!, animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
          Alertift.alert(title: "Error", message: "Error logout")
          .action(.default("OK"))
          .show(on: self)
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

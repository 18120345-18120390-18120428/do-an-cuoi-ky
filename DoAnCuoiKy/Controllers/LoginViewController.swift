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
import FBSDKLoginKit
import GoogleSignIn
class LoginViewController: UIViewController,GIDSignInDelegate {
    // Các biến quản lý đối tượng
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var outlet_dangnhap: UIButton!
    @IBOutlet weak var outlet_fb: UIButton!
    @IBOutlet weak var outlet_gg: UIButton!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        ref = Database.database().reference()
        // Giao diện khung tài khoản
        tfEmail.layer.borderWidth = 1.0
        tfEmail.layer.borderColor = UIColor.darkText.cgColor
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.cornerRadius = 30.0
        
        // Giao diện khung mật khẩu
        tfPassword.layer.borderWidth = 1.0
        tfPassword.layer.borderColor = UIColor.darkText.cgColor
        tfPassword.layer.masksToBounds = true
        tfPassword.layer.cornerRadius = 30.0
        
        // Giao diện khung đăng nhập
        outlet_dangnhap.layer.borderWidth = 1.0
        outlet_dangnhap.layer.borderColor = UIColor.white.cgColor
        outlet_dangnhap.layer.masksToBounds = true
        outlet_dangnhap.layer.cornerRadius = 30.0
        
        // Giao diện khung facebook
        outlet_fb.layer.borderWidth = 1.0
        outlet_fb.layer.borderColor = UIColor.white.cgColor
        outlet_fb.layer.masksToBounds = true
        outlet_fb.layer.cornerRadius = 30.0
        
        // Giao diện khung google
        outlet_gg.layer.borderWidth = 1.0
        outlet_gg.layer.borderColor = UIColor.white.cgColor
        outlet_gg.layer.masksToBounds = true
        outlet_gg.layer.cornerRadius = 30.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfEmail.text! = ""
        tfPassword.text! = ""
    }
    
    
    // Phần Đăng nhập
    @IBAction func btnLogin(_ sender: Any) {
        //Kiem tra dang nhap hop le
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
                Alertift.alert(title: "Error", message: error.localizedDescription)
                .action(.default("OK"))
                .show(on: self)
                return
            }
            if Auth.auth().currentUser != nil {
               //print(Auth.auth().currentUser?.uid)
                let src = self?.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self!.present(src!, animated: true, completion: nil)
                
            }
        }
       
    }

    // Phần quên mật khẩu
    @IBAction func action_quenmatkhau(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let forget = sb.instantiateViewController(withIdentifier: "ForgetViewController")
        self.navigationController?.pushViewController(forget, animated: true)
    }
    
    // Phần Đăng nhập bằng Facebook
    @IBAction func action_fb(_ sender: Any) {
        let loginManager = LoginManager()
        if AccessToken.current == nil {
            loginManager.logIn(permissions: ["public_profile","email"], from: self){(result, error) in
                if let error = error {
                    print("Failed to login: \(error.localizedDescription)")
                    return
                }
                
            }
        }
        guard AccessToken.current != nil else{
            print("Failed to get access token")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                print(error.localizedDescription)
                Alertift.alert(title: "Error", message: error.localizedDescription)
                .action(.default("OK"))
                .show(on: self)
                return
              }
              else{
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                  // Lấy giá trị của user
                    let value = snapshot.value as? NSDictionary
                    let joinDate = value?["joinDate"] as? String ?? ""
                    if joinDate == ""{
                          self.getFBUserData()
                    }
                  
                  }) { (error) in
                    print(error.localizedDescription)
                }
              
                
                print("Facebook Sign In")
                let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                src!.modalPresentationStyle = .fullScreen
                self.present(src!, animated: true, completion: nil)
                
              }
        }
    }
    // lay du lieu tu facebook
    func getFBUserData() {
        //which if my function to get facebook user details
        if((AccessToken.current) != nil){
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.width(480).height(480), email, gender,birthday"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    print(result!)
                    print(dict)
                    // lay avatar
                    let picutreDic = dict as NSDictionary
                    let tmpURL1 = picutreDic.object(forKey: "picture") as! NSDictionary
                    let tmpURL2 = tmpURL1.object(forKey: "data") as! NSDictionary
                    let tmpURL3 = tmpURL2.object(forKey: "url") as! String
                    let finalURL = URL(string: tmpURL3)
                    
                    // lay username
                    let username = picutreDic.object(forKey: "name") as! String
                    // lay dia chi email
                    var email = ""
                    if let tempEmailAddress = picutreDic.object(forKey: "email") {
                        email = tempEmailAddress as! String
                    }
                    else {
                        var usrName = username
                        usrName = usrName.replacingOccurrences(of: " ", with: "")
                        email = usrName+"@facebook.com"
                    }
                    // lay gioi tinh
                    var gender = ""
                    if let tempGender = picutreDic.object(forKey: "gender") {
                        gender = tempGender as! String
                    }
                    // lay ngay sinh
                    var dateOfBirth = ""
                    if let tempDOB = picutreDic.object(forKey: "birthday") {
                        dateOfBirth = tempDOB as! String
                    }
                    let date = Date()
                    let format = DateFormatter()
                    format.dateFormat = "dd-MM-yyyy"
                    let formattedDate = format.string(from: date)
                    self.saveProfile(username: username, email: email, gender: gender, dateOfBirth: dateOfBirth, profileImageURL: finalURL!, joinDate: formattedDate, position: "Member"){ success in
                            if success {
                                print("SAVE SUCCESS FB")
                        }
                    }
                   
                }
                
                print(error?.localizedDescription as Any)
            })
        }
    }
    func saveProfile(username:String,email:String, gender:String, dateOfBirth:String, profileImageURL:URL,joinDate:String, position:String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("Profile/\(uid)")
        
        let userObject = [
            "username": username,
            "email":email,
            "gender": gender,
            "dateOfbirth": dateOfBirth,
            "photoURL": profileImageURL.absoluteString,
            "joinDate": joinDate,
            "position": position
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    // Phần Đăng nhập bằng Google
    @IBAction func action_gg(_ sender: Any) {

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
//
//        let userID = Auth.auth().currentUser?.uid
//        self.ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//          // Lấy giá trị của user
//            let value = snapshot.value as? NSDictionary
//            let joinDate = value?["joinDate"] as? String ?? ""
//            if joinDate == ""{
//                let urlImage = "1"
//                let url = URL(string: urlImage)
//                let date = Date()
//                let format = DateFormatter()
//                format.dateFormat = "dd-MM-yyyy"
//                let formattedDate = format.string(from: date)
//                self.saveProfile(username: "", email: "", gender: "", dateOfBirth: "", profileImageURL: url!, joinDate: formattedDate, position: "Member") { success in
//                    if success {
//                        print("SAVE SUCCESS GG")
//                }
//                }
//            }
//
//          }) { (error) in
//            print(error.localizedDescription)
//        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
          // ...
          if let error = error {
            print(error.localizedDescription)
            return
          }
        
          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
              print(error.localizedDescription)
              return
            }
            print("signIn result: " + authResult!.user.email!)
//            let src = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
//            src!.modalPresentationStyle = .fullScreen
//            self.present(src!, animated: true, completion: nil)
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            let joinDate = value?["joinDate"] as? String ?? ""
            if joinDate == ""{
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd-MM-yyyy"
                let formattedDate = format.string(from: date)
                self.saveProfile(username: authResult!.user.displayName!, email: authResult!.user.email!, gender: "", dateOfBirth: "", profileImageURL: authResult!.user.photoURL!, joinDate: formattedDate, position: "Member") { success in
                    if success {
                        print("SAVE SUCCESS GG")
                    }
                }
            }
    
            }) { (error) in
                print(error.localizedDescription)
                }
          }

        }

        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
              print(error.localizedDescription)
              return
            }
            // Perform any operations when the user disconnects from app here.
            // ...
        }
}

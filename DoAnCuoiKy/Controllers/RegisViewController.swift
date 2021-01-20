//
//  RegisViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/6/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
import Alertift
class RegisViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // Các biến quản lý đối tượng
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfCheckPass: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var outlet_dangky: UIButton!
    @IBOutlet weak var outlet_avatar: UIButton!
    @IBOutlet weak var avatarImg: UIImageView!
    var pickerView = UIPickerView()
    var imagePicker =  UIImagePickerController()
   
    var ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Giao diện khung email
        tfEmail.layer.borderWidth = 1.0
        tfEmail.layer.borderColor = UIColor.darkText.cgColor
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.cornerRadius = 30.0
        
        // Giao diện khung pass
        tfPass.layer.borderWidth = 1.0
        tfPass.layer.borderColor = UIColor.darkText.cgColor
        tfPass.layer.masksToBounds = true
        tfPass.layer.cornerRadius = 30.0
        
        // Giao diện khung check pass
        tfCheckPass.layer.borderWidth = 1.0
        tfCheckPass.layer.borderColor = UIColor.darkText.cgColor
        tfCheckPass.layer.masksToBounds = true
        tfCheckPass.layer.cornerRadius = 30.0
        
        // Giao diện khung user name
        tfUsername.layer.borderWidth = 1.0
        tfUsername.layer.borderColor = UIColor.darkText.cgColor
        tfUsername.layer.masksToBounds = true
        tfUsername.layer.cornerRadius = 30.0
        
        // Giao diện đăng ký
        outlet_dangky.layer.borderWidth = 1.0
        outlet_dangky.layer.borderColor = UIColor.white.cgColor
        outlet_dangky.layer.masksToBounds = true
        outlet_dangky.layer.cornerRadius = 30.0
        
        // Giao diện khung chọn avatar
        outlet_avatar.layer.borderWidth = 1.0
        outlet_avatar.layer.borderColor = UIColor.white.cgColor
        outlet_avatar.layer.masksToBounds = true
        outlet_avatar.layer.cornerRadius = outlet_avatar.frame.size.width / 2
        
        
    }
    
    // Phần chọn Avatar
    @IBAction func action_avatar(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                   self.openGallery()
               }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let pickedImage = info[.originalImage] as? UIImage else {
                return
            }
            avatarImg.image = pickedImage
       
            picker.dismiss(animated: true, completion: nil)
    }
    // ham xy ly upload anh len firebase
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")

        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }

        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        storageRef.putData(imageData, metadata: metaData) { metaData, error in
        if error == nil, metaData != nil {

            storageRef.downloadURL { url, error in
                completion(url)
                // success!
            }
            } else {
                // failed
                completion(nil)
            }
        }
    }
    // ham luu tai khoan dang ky vao realtime firebase
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
    // Phần Đăng ký
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
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPass.text!) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                
                
                // 1. Upload the profile image to Firebase Storage
                let image = self.avatarImg.image
                self.uploadProfileImage(image!) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = self.tfUsername.text!
                        changeRequest?.photoURL = url
                        
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                let date = Date()
                                let format = DateFormatter()
                                format.dateFormat = "dd-MM-yyyy"
                                let formattedDate = format.string(from: date)
                                self.saveProfile(username: self.tfUsername.text!, email: self.tfEmail.text!,gender: "",dateOfBirth: "", profileImageURL: url!, joinDate: formattedDate, position: "Member") { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                Alertift.alert(title: "Error", message: error?.localizedDescription)
                                .action(.default("OK"))
                                .show(on: self)
                                return
                            }
                        }
                    } else {
                        // Error unable to upload profile image
                    }
                    
                }
                
            } else {
                print("Error : \(error!.localizedDescription)")
                Alertift.alert(title: "Error", message: error?.localizedDescription)
                .action(.default("OK"))
                .show(on: self)
                return
            }
        }
    }

}
}

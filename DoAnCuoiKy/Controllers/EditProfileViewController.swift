//
//  EditProfileViewController.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 12/23/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    var pickerView = UIPickerView()
    var imagePicker =  UIImagePickerController()
    var ref: DatabaseReference!
    var isEditImage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Lấy giá trị của user
            let value = snapshot.value as? NSDictionary
            let urlImage = value?["photoURL"] as? String ?? ""
            if urlImage == ""{
                self.Image.image = #imageLiteral(resourceName: "avatar")
            }else{
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                self.Image.image = image
            }
           
            let username = value?["username"] as? String ?? ""
            if username == ""{
                self.tfUsername.placeholder = "Nhập tên tài khoản"
            }else{
                self.tfUsername.text! = username
            }
            
            let gender = value?["gender"] as? String ?? ""
            if gender == ""{
                self.tfGender.placeholder = "Nhập giới tính"
            }else{
                self.tfGender.text! = gender
            }
            let dateOfBirth = value?["dateOfbirth"] as? String ?? ""
            if dateOfBirth == ""{
                self.tfDateOfBirth.placeholder = "Nhập ngày sinh"
            }else{
                 self.tfDateOfBirth.text! = dateOfBirth
            }
            let email = value?["email"] as? String ?? ""
            if email == ""{
                self.tfEmail.placeholder = "Nhập Email"
            }else{
                 self.tfEmail.text! = email
            }

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
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
    @IBAction func BtnBack(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnSave(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("Profile/\(uid)")
        print("hungakka \(isEditImage)")
        if  isEditImage == 1{
            let image = self.Image.image
            uploadProfileImage(image!) { url in
                if url != nil {
                    ref.updateChildValues([
                        "username": self.tfUsername.text ?? "",
                        "email": self.tfEmail.text ?? "",
                        "gender": self.tfGender.text ?? "",
                        "dateOfbirth": self.tfDateOfBirth.text ?? "",
                        "photoURL": url!.absoluteString
                    ])
                }
            }
        }else{
            ref.updateChildValues([
                "username": self.tfUsername.text ?? "",
                "email": self.tfEmail.text ?? "",
                "gender": self.tfGender.text ?? "",
                "dateOfbirth": self.tfDateOfBirth.text ?? ""
            ])
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnGetImage(_ sender: Any) {
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
            Image.image = pickedImage
            isEditImage = 1
            picker.dismiss(animated: true, completion: nil)
    }
    
}

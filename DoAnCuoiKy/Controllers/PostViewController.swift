//
//  PostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import FirebaseStorage


class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var mainAvatar: UIImage!
    var storyTitle = ""
    var category = ""
    var author = ""
    var newdescription = ""
    var newStory = Story()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Khai bao table view
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoseAvatarTableViewCell") as! ChoseAvatarTableViewCell
            cell.mainAvatar.image = newStory.avatar
            cell.coverAvatar.image = UIImage(named: "background01")
            cell.delegate = self
            return cell
        }
        if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFiledTableViewCell") as! TextFiledTableViewCell
            cell.tfName.placeholder = "Tên truyện"
            cell.tfName.text = newStory.name
            cell.tfAuthor.placeholder = "Tác giả"
            cell.tfAuthor.text = newStory.author
            cell.delegate = self
            return cell
        }
        if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerTableViewCell") as! PickerTableViewCell
            cell.tfInfo.placeholder = "Thể loại"
            cell.tfInfo.text = newStory.category
            cell.delegate = self
            return cell
        }
        if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputDesTableViewCell") as! InputDesTableViewCell
            print(newStory.description)
            cell.tvDescription.text = newStory.description
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell") as! ButtonTableViewCell
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 200
        }
        if (indexPath.row == 1) {
            return 120
        }
        if (indexPath.row == 2) {
            return 60
        }
        if (indexPath.row == 3) {
            return 300
        }
        return 50
    }
}
extension PostViewController: ChoseAvatarTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func choseImage() {
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
        newStory.avatar = pickedImage
        tableView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
extension PostViewController: ButtonTableViewCellDelegate, TextFiledTableViewCellDelegate, PickerTableViewCellDelegate, InputDesTableViewCellDelegate {
    func getName(text: String) {
        newStory.name = text
    }
    func getAuthor(text: String) {
        newStory.author = text
    }
    func getDescription(text: String) {
        print("description: \(text)")
        newStory.description = text
    }
    func getCategory(text: String) {
        newStory.category = text
    }
    func tapNext() {
        print(newStory.description)
        performSegue(withIdentifier: "addChapter", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addChapterViewController = segue.destination as! AddChapterViewController
        addChapterViewController.newStory = newStory
    }
}
    // Các biến quản lý đối tượng
//    @IBOutlet var storyNameField: UITextField!
//    @IBOutlet var authorFiled: UITextField!
//    @IBOutlet var categoryFiled: UITextField!
//    @IBOutlet var avatarImage: UIImageView!
//    @IBOutlet var btnChoseImage: UIButton!
//    @IBOutlet var tableView: UITableView!
//    var pickerView = UIPickerView()
//    @IBOutlet weak var btnSave: UIButton!
//    @IBOutlet weak var btnBack: UIButton!
//    var imagePicker =  UIImagePickerController()
//    var newStory = Story()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Khai báo Table View
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        // Khai báo Picker View
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        categoryFiled.inputView = pickerView
//        pickerView.layer.backgroundColor = UIColor.white.cgColor
//        pickerView.layer.borderWidth = 3.0
//        pickerView.layer.borderColor = UIColor.darkGray.cgColor
//
//        // Giao diện khung tên truyện
//        storyNameField.layer.borderWidth = 1.0
//        storyNameField.layer.borderColor = UIColor.darkText.cgColor
//        storyNameField.layer.masksToBounds = true
//        storyNameField.layer.cornerRadius = 30.0
//
//        // Giao diện khung tác giả
//        authorFiled.layer.borderWidth = 1.0
//        authorFiled.layer.borderColor = UIColor.darkText.cgColor
//        authorFiled.layer.masksToBounds = true
//        authorFiled.layer.cornerRadius = 30.0
//
//        // Giao diện khung thể loại
//        categoryFiled.layer.borderWidth = 1.0
//        categoryFiled.layer.borderColor = UIColor.darkText.cgColor
//        categoryFiled.layer.masksToBounds = true
//        categoryFiled.layer.cornerRadius = 30.0
//
//        // Giao diện Avatar
//        avatarImage.layer.cornerRadius = 30.0
//
//        // Giao diện nút chọn Avatar
//        btnChoseImage.layer.cornerRadius = btnChoseImage.frame.width/2
//
//        // Giao diện Lưu
//        btnSave.layer.borderColor = UIColor.white.cgColor
//        btnSave.layer.borderWidth = 1.0
//        btnSave.layer.cornerRadius = 30.0
//
//        // Giao diện Trở về
//        btnBack.layer.borderColor = UIColor.systemPink.cgColor
//        btnBack.layer.borderWidth = 1.0
//        btnBack.layer.cornerRadius = 30.0
//
//
//
//        // Hiển thị nội dung phụ lục truyện
//        storyNameField.text = newStory.name
//        authorFiled.text = newStory.author
//        categoryFiled.text = newStory.category
//        avatarImage.image = newStory.avatar
//    }
//
//    let category = ["Ngôn Tình", "Kiếm Hiệp", "Truyện Teen", "Truyện Ma", "Quân Sự", "Trinh Thám", "Lịch Sử", "Tiểu Thuyết", "Thiếu Nhi", "Truyện Ngắn", "Truyện Cười", "Cổ Tích", "Nước Ngoài", "Khoa Học","Truyện Voz"]
//    var indexUpdate = -1
//    // Phần Picker View
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return category.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return category[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        categoryFiled.text = category[row]
//        categoryFiled.resignFirstResponder()
//    }
//
    // Phần chọn Avatar
//    @IBAction func actionChoseImage(_ sender: Any) {
//        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
//            self.openGallery()
//        }))
//
//        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//    func openGallery()
//    {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.allowsEditing = true
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//        else
//        {
//            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let pickedImage = info[.originalImage] as? UIImage else {
//            return
//        }
//        avatarImage.image = pickedImage
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//
//    // Phần Table View
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newStory.storyContent.count
//     }
//
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//         return 50
//     }
//
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableCell") as! PostTableViewCell
//
//        // Nội dung Cell
//        cell.outlet_chuong.text = "Chương \(newStory.storyContent[indexPath.row].chapterOrder)"
//        cell.outlet_tenchuong.text = newStory.storyContent[indexPath.row].chapterName
//
//
//        // Giao diện Cell
//        cell.outlet_chuong.layer.borderColor = UIColor.darkText.cgColor
//        cell.outlet_chuong.layer.borderWidth = 1.0
//
//        cell.outlet_tenchuong.layer.borderColor = UIColor.darkText.cgColor
//        cell.outlet_tenchuong.layer.borderWidth = 1.0
//
//         return cell
//     }
//
//    // Phần Thêm chương
//    @IBAction func actionAddNewChapter(_ sender: Any) {
//        performSegue(withIdentifier: "chapter", sender: self)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let postChapterViewController = segue.destination as! PostChapViewController
//        if (self.indexUpdate > -1) {
//            postChapterViewController.chapter = newStory.storyContent[indexUpdate]
//        }
//
//    }
//    // Phần Lưu
//    @IBAction func actionSave(_ sender: Any) {
//
//        newStory.addSimpleStory(name: storyNameField.text!, author: authorFiled.text!, category: categoryFiled.text!,
//                                avatar: avatarImage.image!)
//        let child = SpinnerViewController()
//
//        // add the spinner view controller
//        addChild(child)
//        child.view.frame = view.frame
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//        print(newStory.storyContent[0].chapterContent)
//        let uploadTask = newStory.pushToFirebase()
//        uploadTask.observe(.success) { snapshot in
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                print("Simulation finished")
//                // then remove the spinner view controller
//                child.willMove(toParent: nil)
//                child.view.removeFromSuperview()
//                child.removeFromParent()
//            }
//        }
//    }

//    // Phần trở về
//    @IBAction func actionBack(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//
//extension PostViewController: UpdatePostTable {
//    func updateInfo(newChapter: Chapter) {
//        newStory.storyContent.append(newChapter)
//
//        tableView.reloadData()
//    }
//}

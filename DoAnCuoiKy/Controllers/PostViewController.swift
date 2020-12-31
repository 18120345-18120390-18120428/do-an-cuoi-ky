//
//  PostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol PostViewControllerDelegate: class {
    func addNewStory(newStory: Story)
}

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var mainAvatar: UIImage!
    var storyTitle = ""
    var category = ""
    var author = ""
    var newdescription = ""
    var newStory = Story()
    weak var delegate: PostViewControllerDelegate?
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
        delegate?.addNewStory(newStory: newStory)
        performSegue(withIdentifier: "addChapter", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addChapterViewController = segue.destination as! AddChapterViewController
        addChapterViewController.newStory = newStory
    }
}

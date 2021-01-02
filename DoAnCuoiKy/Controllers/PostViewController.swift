//
//  PostViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/14/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

protocol PostViewControllerDelegate: class {
    func addNewStory(newStory: Story)
}

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var mainAvatar: UIImage!
    var storyName = ""
    var category = ""
    var author = ""
    var newdescription = ""
    var arrayStory : [Story] = []
    private var newStory = Story()
    var ref = Database.database().reference()
    weak var delegate: PostViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Khai bao table view
        tableView.delegate = self
        tableView.dataSource = self
        if (storyName != "") {
            fetchStory(name: storyName)
        }
    }
    func fetchStory(name: String) {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        ref.child("Stories").queryOrdered(byChild: "name").queryStarting(atValue: name).queryEnding(atValue: storyName+"\u{f8ff}").observe(.value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                let author = storyDict["author"] as! String
                let category = storyDict["category"] as! String
                let urlImage = storyDict["avatar"] as! String
                let description = storyDict["description"] as! String
                let updateDay = storyDict["timestamp"] as! String
                let newStory: Story = Story()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let date = dateFormatter.date(from:updateDay)!
                newStory.timestamp = date
                let url = URL(string: urlImage)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)!
                newStory.addSimpleStory(name: name, author: author, category: category, avatar: image)
                newStory.description = description
                let storyContent = snap.childSnapshot(forPath: "storyContent")
                for chapter in storyContent.children {
                    let snap1 = chapter as! DataSnapshot
                    let chapterDict = snap1.value as! [String: Any]
                    let chapterOrder = chapterDict["chapterOrder"] as! String
                    let chapterName = chapterDict["chapterName"] as! String
                    let chapterContent = chapterDict["chapterContent"] as! String
                    let newChapter = Chapter()
                    newChapter.addNewChapter(chapterOrder: chapterOrder, chapterName: chapterName, chapterContent: chapterContent)
                    newStory.storyContent.append(newChapter)
                }
                print("new story: \(newStory.name)")
                self.arrayStory.append(newStory)
                self.newStory = self.arrayStory.first!
                print("Story: \(self.newStory.description)")
                self.tableView.reloadData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        })
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
            print("jojjoojojo \(newStory.category)")
            cell.tfInfo.text = newStory.category
            cell.delegate = self
            return cell
        }
        if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputDesTableViewCell") as! InputDesTableViewCell
            print("jojjoojojo \(newStory.description)")
            cell.tvDescription.text = self.newStory.description
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
//        print("delegate: \(newStory.description)")
        if (text != "") {
            newStory.description = text
        }
    }
    func getCategory(text: String) {
        newStory.category = text
    }
    func tapNext() {
        performSegue(withIdentifier: "addChapter", sender: self)
    }
    func tapSave() {
        delegate?.addNewStory(newStory: newStory)
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        self.newStory.numberOfChapters = self.newStory.storyContent.count
        let uploadTask = newStory.pushToFirebase()
        uploadTask.observe(.success) { snapshot in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("Simulation finished")
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addChapterViewController = segue.destination as! AddChapterViewController
        addChapterViewController.newStory = newStory
    }
}

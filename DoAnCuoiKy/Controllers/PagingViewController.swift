//
//  PagingViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 1/20/21.
//  Copyright © 2021 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

protocol namePagingViewControllerDelegate: class {
    func paging(name: String)
}
class PagingViewController: UIViewController {
    var ref = Database.database().reference()
    var listName: [String] = []
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfPage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    weak var delegate: namePagingViewControllerDelegate!
    @IBAction func actSend() {
        let number = Int(tfPage.text!)
        if (number == nil) {
            showAlert(message: "Invalid number")
        } else {
            let index = (number! - 1) * 10 - 1
            if (index < listName.count && index >= -1) {
                var name = ""
                if (index == -1) {
                    name = ""
                } else {
                    name = listName[index]
                }
                print(name)
                delegate.paging(name: name)
                dismiss(animated: false, completion: nil)
            } else {
                let limitPage = (listName.count - 1) / 10 + 1
                showAlert(message: "Out range page (1-\(limitPage))")
            }
            
        }
        
    }
    @IBAction func actCancel() {
        dismiss(animated: false, completion: nil)
    }
    func showAlert(message: String) {
        // create the alert
        let alert = UIAlertController(title: "Cảnh báo", message: "\(message)", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func getListNameStory() {
        ref.child("Stories").queryOrdered(byChild: "name").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                self.listName.append(name)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.layer.cornerRadius = 10
        btnSend.layer.cornerRadius = 5
        btnCancel.layer.cornerRadius = 5
        getListNameStory()
    }
}

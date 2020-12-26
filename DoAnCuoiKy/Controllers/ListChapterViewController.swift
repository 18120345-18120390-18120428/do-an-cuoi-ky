//
//  ListChapterViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

protocol ListChapterViewControllerDelegate: class {
    func updateIndex(index: Int)
}
class ListChapterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    weak var delegate: ListChapterViewControllerDelegate?
    var content: [Chapter] = []
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTableViewCell") as! ChapterTableViewCell
        cell.lbChapter.text = "\(content[indexPath.row].chapterOrder). Chương \(content[indexPath.row].chapterOrder): \(content[indexPath.row].chapterName)"
        if (indexPath.row == currentIndex) {
            cell.lbChapter.textColor = .purple
        } else {
            cell.lbChapter.textColor = .black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        tableView.reloadData()
        delegate?.updateIndex(index: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
}

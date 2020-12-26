//
//  AddChapterViewController.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/26/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class AddChapterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var newStory = Story()
    var indexUpdate = -1
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSave: UIButton!
    @IBAction func actionSave(_ sender: Any) {
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        let uploadTask = newStory.pushToFirebase()
        uploadTask.observe(.success) { snapshot in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                print("Simulation finished")
                // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
    @IBAction func actionAdd(_ sender: Any) {
        indexUpdate = -1
        performSegue(withIdentifier: "detailChapter", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newStory.storyContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTableViewCell") as! ChapterTableViewCell
        cell.lbChapter.text = "\(newStory.storyContent[indexPath.row].chapterOrder). Chương \(newStory.storyContent[indexPath.row].chapterOrder): \(newStory.storyContent[indexPath.row].chapterName)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexUpdate = indexPath.row
        performSegue(withIdentifier: "detailChapter", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postChapViewController = segue.destination as! PostChapViewController
        postChapViewController.delegate = self
        if (indexUpdate > -1) {
            postChapViewController.chapter = newStory.storyContent[indexUpdate]
        }
    }
}
extension AddChapterViewController: PostChapViewControllerDelegate {
    func updateInfo(newChapter: Chapter) {
        if (newStory.storyContent.last?.chapterOrder != newChapter.chapterOrder) {
            newStory.storyContent.append(newChapter)
        }
        tableView.reloadData()
    }
}

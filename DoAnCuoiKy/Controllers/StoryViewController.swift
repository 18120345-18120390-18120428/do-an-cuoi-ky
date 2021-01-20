//
//  StoryViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    // Các biến quản lý đối tượng
    @IBOutlet weak var textViewContent: UITextView!
    var Online = true
    var content: [Chapter] = []
    var currentIndex = 0
    var nameStory = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if (content.count == 0) {
            
        }
        else {
            textViewContent.text = """
                \(content[currentIndex].chapterContent)
            """
        }
               
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // an navigationbar
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//        // an tabbar
//        self.tabBarController?.tabBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        if self.isMovingFromParent {
//            self.tabBarController?.tabBar.isHidden = false
//        }
//    }
    
    // Phần Trở về
    @IBAction func actionBack(_ sender: Any) {
        Online = true
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionListChapter(_ sender: Any) {
        performSegue(withIdentifier: "choseChapter", sender: self)
    }
    @IBAction func actComment(_ sender: Any) {
        if(Online){
            performSegue(withIdentifier: "commentReadStory", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ListChapterViewController {
            let listChapterViewController = segue.destination as! ListChapterViewController
            listChapterViewController.delegate = self
            listChapterViewController.content = content
            listChapterViewController.currentIndex = currentIndex
        }
        else if segue.destination is CommentViewController {
            let commentViewController = segue.destination as! CommentViewController
            commentViewController.nameStory = nameStory
        }
    }
    
}
extension StoryViewController: ListChapterViewControllerDelegate {
    func updateIndex(index: Int) {
        currentIndex = index
        textViewContent.text = """
            \(content[currentIndex].chapterContent)
        """
    }
    
}

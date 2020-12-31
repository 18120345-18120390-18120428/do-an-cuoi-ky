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
    var content: [Chapter] = []
    var currentIndex = 0
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
    
    // Phần Trở về
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionListChapter(_ sender: Any) {
        performSegue(withIdentifier: "choseChapter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listChapterViewController = segue.destination as! ListChapterViewController
        listChapterViewController.delegate = self
        listChapterViewController.content = content
        listChapterViewController.currentIndex = currentIndex
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

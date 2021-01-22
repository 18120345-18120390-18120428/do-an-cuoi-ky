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
    
    
    
    @IBOutlet weak var turnOnLight: UIButton!
    @IBOutlet weak var turnOffLight: UIButton!
    @IBOutlet weak var arial: UIButton!
    @IBOutlet weak var timenew: UIButton!
    @IBOutlet weak var futura: UIButton!
    @IBOutlet weak var rockwell: UIButton!
    @IBOutlet weak var snell: UIButton!
    @IBOutlet weak var geeza: UIButton!
    @IBOutlet weak var size: UISlider!
    @IBOutlet weak var interfaceEditing: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (content.count == 0) {
            
        }
        else {
            textViewContent.text = """
                \(content[currentIndex].chapterContent)
            """
        }
        
        // Ẩn giao diện chỉnh sửa
        interfaceEditing.isHidden = true;
        
        // Giao diện chỉnh sửa
        turnOnLight.layer.borderColor = UIColor.white.cgColor
        turnOnLight.layer.borderWidth = 1.0
        turnOffLight.layer.borderColor = UIColor.white.cgColor
        turnOffLight.layer.borderWidth = 1.0
        arial.layer.borderColor = UIColor.white.cgColor
        arial.layer.borderWidth = 1.0
        timenew.layer.borderColor = UIColor.white.cgColor
        timenew.layer.borderWidth = 1.0
        futura.layer.borderColor = UIColor.white.cgColor
        futura.layer.borderWidth = 1.0
        rockwell.layer.borderColor = UIColor.white.cgColor
        rockwell.layer.borderWidth = 1.0
        snell.layer.borderColor = UIColor.white.cgColor
        snell.layer.borderWidth = 1.0
        geeza.layer.borderColor = UIColor.white.cgColor
        geeza.layer.borderWidth = 1.0
        
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
    
    // Nút chỉnh sửa
    @IBAction func actEdit(_ sender: Any) {
        if (interfaceEditing.isHidden == true) {
            interfaceEditing.isHidden = false
        } else {
            interfaceEditing.isHidden = true
        }
    }
    
    // TurnOnLight
    @IBAction func actTurnOnLight(_ sender: Any) {
        view.backgroundColor = UIColor.white
        textViewContent.backgroundColor = UIColor.white
        textViewContent.textColor = UIColor.darkText
        
    }
    
    // TurnOffLight
    @IBAction func actTurnOffLight(_ sender: Any) {
        view.backgroundColor = UIColor.darkGray
        textViewContent.backgroundColor = UIColor.darkGray
        textViewContent.textColor = UIColor.white
    }
    
    // Kiểu chữ
    @IBAction func actArial(_ sender: Any) {
        textViewContent.font = UIFont(name: "Arial", size: CGFloat(size.value))
    }
    
    @IBAction func actTimeNewRoman(_ sender: Any) {
        textViewContent.font = UIFont(name: "Times New Roman", size: CGFloat(size.value))
    }
    
    @IBAction func actFutura(_ sender: Any) {
        textViewContent.font = UIFont(name: "Futura", size: CGFloat(size.value))
    }
    
    @IBAction func actRockwell(_ sender: Any) {
        textViewContent.font = UIFont(name: "Rockwell", size: CGFloat(size.value))
    }
    
    
    @IBAction func actSnell(_ sender: Any) {
        textViewContent.font = UIFont(name: "Snell Roundhand", size: CGFloat(size.value))
    }
    
    
    @IBAction func actGeeza(_ sender: Any) {
        textViewContent.font = UIFont(name: "Geeza Pro", size: CGFloat(size.value))
    }
    
    // Phần Size Text
    @IBAction func actSizeText(_ sender: Any) {
        textViewContent.font = UIFont(name: textViewContent.font?.fontName ?? "Arial" , size: CGFloat(size.value))
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

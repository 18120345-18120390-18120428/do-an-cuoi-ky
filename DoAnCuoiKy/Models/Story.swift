//
//  Story.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/18/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class Story {
    var name: String = ""
    var author: String = ""
    var category: String = ""
    var description: String = ""
    var avatar: UIImage = UIImage(named: "avatar")!
    var likes: Int = 0
    var views: Int = 0
    var downloads: Int = 0
    var rating: [String: Int] = [:]
    var status: Bool = false
    var numberOfChapters: Int = 0
    var storyContent: [Chapter] = []
    var timestamp: Date = Date()
    func addSimpleStory(name: String, author: String, category: String, avatar: UIImage) {
        self.name = name
        self.author = author
        self.category = category
        self.avatar = avatar
    }
    func addNewChapter(chapter: Chapter) {
        self.storyContent.append(chapter)
    }
    func liked() {
        self.likes = self.likes + 1
    }
    func unliked() {
        self.likes = self.likes - 1
    }
    func viewed() {
        self.views = self.views + 1
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func pushToFirebase() -> StorageUploadTask {
        let image = resizeImage(image: self.avatar, targetSize: CGSize.init(width: 150, height: 150))
        let storage = Storage.storage().reference()
        guard let imageData = image.pngData() else {
            return StorageUploadTask.init()
        }
        let ref = storage.child("images/avatar[\(self.name)].png")
        let uploadTask = ref.putData(imageData, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            ref.downloadURL { url, error in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let updateDay = formatter.string(from: date)
                let database = Database.database().reference()
                let object: [String: Any] = [
                    "name": self.name,
                    "author": self.author,
                    "rating": self.rating,
                    "avatar": downloadURL.absoluteString,
                    "category": self.category,
                    "likes": self.likes,
                    "views": self.views,
                    "donloads": self.downloads,
                    "status": self.status,
                    "numberOfChapters": self.numberOfChapters,
                    "description": self.description,
                    "timestamp": updateDay
                ]
                database.child("Stories/\(self.name)").setValue(object)
                for story in self.storyContent {
                    let objectChapter: [String: Any] = [
                        "chapterOrder": story.chapterOrder,
                        "chapterName": story.chapterName,
                        "chapterContent": story.chapterContent
                    ]
                    database.child("Stories/\(self.name)").child("storyContent").child("\(story.chapterOrder)").setValue(objectChapter)
                }
                print("Add success!")
                return
            }
        })
        return uploadTask
    }
    
}

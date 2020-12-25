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
    var rating: Float = 0.0
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
    func rated(newRating: Float) {
        self.rating = newRating
    }
    func pushToFirebase() -> StorageUploadTask {
        
        let image: UIImage = self.avatar
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
//                urlString = downloadURL.absoluteString
//                print(urlString)
//                UserDefaults.standard.set(urlString, forKey: "url")
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

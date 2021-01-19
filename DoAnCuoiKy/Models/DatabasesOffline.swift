//
//  DatabasesOffline.swift
//  DoAnCuoiKy
//
//  Created by Nguyen Dinh Hung on 1/19/21.
//  Copyright © 2021 AnhKiem. All rights reserved.
//

import Foundation
import RealmSwift
// khai bao lop chua doi tuong
class StoryContent: Object {
    @objc dynamic var chapterOrder:String = ""
    @objc dynamic var chapterName:String = ""
    @objc dynamic var chapterContent:String = ""
}
class Item: Object {
    
    @objc dynamic var ID:Int = 0;
    @objc dynamic var name: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var descript: String = ""
   //@objc dynamic var avatar: UIImage = UIImage(named: "avatar")!
    //@objc dynamic var likes: Int = 0
    //@objc dynamic var views: Int = 0
    //@objc dynamic var downloads: Int = 0
    //@objc dynamic var rating: [String: Int] = [:]
    @objc dynamic var status: Bool = false
    @objc dynamic var numberOfChapters: Int = 0
    @objc dynamic var timestamp: Date = Date()
    let storyContent = List<StoryContent>()
    override static func primaryKey() ->String {
        return "ID"
    }
}

class DBManager{
    
    private var database:Realm
    // Bien chua thuc the duy nhat cua lop DBManager trong toan bo chuong trinh
    static let sharedInstance = DBManager()
    static var autoID:Int = 0;
    //khoi tao bien UserDefault data de luu lai autoID
    let userData:UserDefaults!
    private init(){
        //khoi tao database realm
        database = try! Realm()
        // khoi tao userData va doc thong tin autoID
        userData = UserDefaults.standard
        DBManager.autoID = userData.integer(forKey: "autoID")
    }
    //Ham lay data
    func getDataFromDB() -> Results<Item>{
        let result: Results<Item> = database.objects(Item.self)
        return result
    }
    func addData(object:Item) {
        try! database.write {
            DBManager.autoID += 1
            object.ID = DBManager.autoID
            database.add(object)
            //Luu lai thong tin autoID hien tai vao userData
            userData.set(DBManager.autoID, forKey: "autoID")
        }
    }
    // ham so 1 doi tuong
    func deleteItemFromDB(object:Item) {
        do {
            try database.write {
                database.delete(object)
            }
            
        }
        catch{
            print("xoa that bai")        }
    }
    // Ham xoa toan bo du lieu
    func deleteAllFromDB()  {
        do {
            try database.write {
                database.deleteAll()
            }
            
        }
        catch {
            print("xoa that bai")
        }
    }
    func updateDB(object:Item) {
        do {
            try database.write {
                database.add(object, update: .modified)
            }
            
        }
        catch {
            print("update that bai")
        }
    }
    
}

//
//  SearchViewController.swift
//  DoAnCuoiKy
//
//  Created by AnhKiem on 12/16/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UISearchResultsUpdating {
    var ref = Database.database().reference()
    var listStory: [Story] = []
    var listName: [String] = []
    var indexUpdate = -1
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.darkText
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        definesPresentationContext = true
        getListNameStory()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
//        searchController.searchBar.isSearchResultsButtonSelected
        if (text != "") {
            fetchStories(name: text)
        } else {
            listStory.removeAll()
            tableView.reloadData()
        }
    }
    func getListNameStory() {
        ref.child("Stories").queryOrdered(byChild: "name").observe(.value, with: {snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let storyDict = snap.value as! [String: Any]
                let name = storyDict["name"] as! String
                self.listName.append(name)
            }
        })
    }
    func convertName(name: String) -> [String] {
        var result: [String] = []
        for text in listName {
            if text.lowercased().contains(name.lowercased()) {
                result.append(text)
            }
        }
        
        return result
    }
    public func fetchStories(name: String) {
        let listData = convertName(name: name)
        listStory.removeAll()
        for data in listData {
            ref.child("Stories").queryOrdered(byChild: "name").queryStarting(atValue: data).queryEnding(atValue: data+"\u{f8ff}").observe(.value, with: {snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let storyDict = snap.value as! [String: Any]
                    let name = storyDict["name"] as! String
                    let newStory: Story = Story()
                    newStory.name = name
                    print("Name: \(name)")
                    self.listStory.append(newStory)
                    self.tableView.reloadData()
                }
            })
        }
        
        
    }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterTableViewCell") as! ChapterTableViewCell
        cell.lbChapter?.text = listStory[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexUpdate = indexPath.row
        print("index update: \(self.indexUpdate)")
        performSegue(withIdentifier: "searchStory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let InfoStoryViewController = segue.destination as! InformationStoryViewController
        print("Story name: \(listStory[indexUpdate].name)")
        InfoStoryViewController.storyName = listStory[indexUpdate].name
    }
}

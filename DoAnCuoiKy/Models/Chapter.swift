//
//  Chapter.swift
//  DoAnCuoiKy
//
//  Created by Pham Minh Duy on 12/18/20.
//  Copyright © 2020 AnhKiem. All rights reserved.
//

import Foundation

class Chapter {
    var chapterOrder: String = ""
    var chapterName: String = ""
    var chapterContent: String = ""
    func addNewChapter (chapterOrder: String, chapterName: String, chapterContent: String) {
        self.chapterOrder = chapterOrder
        self.chapterName = chapterName
        self.chapterContent = chapterContent
    }
}

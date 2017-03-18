//
//  Article.swift
//  NewsProject
//
//  Created by Stepan Paholyk on 3/18/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

import UIKit

class Article: NSObject {

    var kAuthor: String
    var kTitle: String
    var kDescription: String
    var kUrl: String
    var kUrlToImage: String
    var KPublishedAt: String
    
    
    init(response: [String:String]) {
        self.kAuthor = response["author"]!
        self.kTitle = response["title"]!
        self.kDescription = response["description"]!

        self.kUrl = response["url"]!

        self.kUrlToImage = response["urlToImage"]!

        self.KPublishedAt = response["publishedAt"]!

    }

}
